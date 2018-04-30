# frozen_string_literal: true

class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true
  validates :google_places_id,
            uniqueness: { case_sensitive: false },
            allow_nil: true

  has_many :currencies_listings
  has_many :currencies, through: :currencies_listings
  belongs_to :submitter, class_name: :User, inverse_of: :submissions

  # Get lat and long, unless listing comes from google places
  after_validation :geocode, unless: :google_places_id

  ALLOWED_STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"].freeze

  # https://github.com/alexreisner/geocoder
  geocoded_by :full_address, latitude: :lat, longitude: :long
  reverse_geocoded_by :lat, :long

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
