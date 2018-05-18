# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :name, :symbol, presence: true

  has_many :currencies_listings
  has_many :listings, through: :currencies_listings

  def icon_path
    "crypto_icons/32/color/#{symbol.downcase}.png"
  end
end
