class Currency < ApplicationRecord
  validates :name, :symbol, presence: true

  has_many :currencies_listings
  has_many :listings, through: :currencies_listings
end
