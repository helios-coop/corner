# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :categories_listings
  has_many :listings, through: :categories_listings
end
