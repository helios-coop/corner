class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true

  has_many :currency_listings
  has_many :currencies, through: :currency_listings
end
