# frozen_string_literal: true

class CategoriesListing < ApplicationRecord
  validates :category_id, :listing_id, presence: true

  belongs_to :category
  belongs_to :listing
end
