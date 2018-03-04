class Currency < ApplicationRecord
  validates :name, :symbol, presence: true

  has_many :currency_listings
  has_many :listings, through: :currency_listings
end
