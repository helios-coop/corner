# frozen_string_literal: true

class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true
  validates :google_places_id,
            uniqueness: { case_sensitive: false },
            allow_nil: true

  has_many :currencies_listings
  has_many :currencies, through: :currencies_listings
  belongs_to :submitter, class_name: :User, inverse_of: :submissions

  has_many :categories_listings
  has_many :categories, through: :categories_listings

  # Get lat and long, unless listing comes from google places
  after_validation :geocode, unless: :google_places_id

  # Active Storage
  # https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
  has_many_attached :images
  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }

  # Search By Name
  include PgSearch
  pg_search_scope :search_by_name,
                  against: :name,
                  using: { tsearch: { prefix: true } }

  # Search By Location
  # https://github.com/alexreisner/geocoder
  geocoded_by :full_address, latitude: :lat, longitude: :long
  reverse_geocoded_by :lat, :long

  ALLOWED_STATES = load_data("states")

  SEARCHES = {
    name: ->(scope, term) { scope.search_by_name(term) },
    location: ->(scope, term) { scope.near(term, 5) },
    category: ->(scope, term) { scope.merge(Category.search_by_name(term)) },
    coordinates: ->(scope, term) { scope.near(term, 5) },
  }.freeze

  # def self.full_search(search_options)
  #   scope = self
  #
  #   search_options.each do |search_type, term|
  #     scope = SEARCHES.fetch(search_type).call(scope, term)
  #   end
  #
  #   scope
  # end

  # Ok, this is cray cray (but works until Robert makes me clean it up)
  def self.full_search(search_options)
    name_query = search_options[:name]
    location_query = search_options[:location]
    category_query = search_options[:category]
    coordinates_query = search_options[:coordinates]

    if name_query && location_query && category_query
      near(location_query, 5).search_by_name(name_query).select do |listing|
        (listing.categories & Category.search_by_name(category_query)).any?
      end.flatten.uniq
    elsif name_query && location_query
      near(location_query, 5).search_by_name(name_query)
    elsif name_query && category_query
      search_by_name(name_query).select do |listing|
        (listing.categories & Category.search_by_name(category_query)).any?
      end.flatten.uniq
    elsif location_query && category_query
      near(location_query, 5).select do |listing|
        (listing.categories & Category.search_by_name(category_query)).any?
      end.flatten.uniq
    elsif name_query
      search_by_name(name_query)
    elsif location_query
      near(location_query, 5)
    elsif category_query
      categories = Category.search_by_name(category_query)
      categories.map(&:listings).flatten.uniq
    elsif coordinates_query
      near(coordinates_query, 5)
    end
  end

  # Used by geocoder. Here we construct the full address on the fly.
  # Google Places returns a formatted address. For performance reasons it might
  # make sense to store this all in a column at creation time.
  # https://github.com/alexreisner/geocoder#model-configuration
  def full_address
    [address, city, state, zipcode, country].compact.join(", ")
  end

  def coordinates
    [lat, long]
  end

  def editable_by?(user)
    user == submitter || ["admin", "moderator"].include?(user.role)
  end

  def replace_currencies(currencies)
    new_currencies = currencies - self.currencies
    removed_currencies = self.currencies - currencies
    currencies_listings.where(currency_id: removed_currencies).destroy_all
    self.currencies += new_currencies
  end
end
