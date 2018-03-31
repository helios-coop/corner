# frozen_string_literal: true

class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true
  validates :google_places_id, uniqueness: true

  has_many :currencies_listings
  has_many :currencies, through: :currencies_listings
  belongs_to :submitter, class_name: :User, inverse_of: :submissions

  # https://github.com/alexreisner/geocoder
  geocoded_by :full_address, latitude: :lat, longitude: :long
  reverse_geocoded_by :lat, :long

  # Used by geocoder. Here we construct the full address on the fly.
  # Google Places returns a formatted address. For performance reasons it might
  # make sense to store this all in a column at creation time.
  # https://github.com/alexreisner/geocoder#model-configuration
  def full_address
    [address, city, state, zipcode, country].compact.join(', ')
  end

  def editable_by?(user)
    return true if user.role == 'admin'
    return true if user.role == 'moderator'
    return true if submitter == user

    false
  end
end
