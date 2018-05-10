# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :categories_listings
  has_many :listings, through: :categories_listings

  # Search By Name
  include PgSearch
  pg_search_scope :search_by_name,
                  against: :name,
                  using: { tsearch: { prefix: true } }
end
