class CurrencyListing < ApplicationRecord
  acts_as_paranoid

  validates :currency_id, :listing_id, presence: true
end
