# frozen_string_literal: true

class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true

  has_many :currencies_listings
  has_many :currencies, through: :currencies_listings
  belongs_to :submitter, class_name: :User, inverse_of: :submissions

  def add_new_currencies(new_currencies)
    new_currencies.each do |currency|
      # Currency is live on the listing
      next if currencies.include? currency

      # Currency was previously on listing but was soft_deleted
      if currencies_listings.with_deleted
                            .pluck(:currency_id).include? currency.id
        # Undelete
        currencies_listings.with_deleted
                           .find_by(currency_id: currency.id).recover
      else
        currencies << currency
      end
    end
  end

  def remove_currencies(new_currencies)
    currencies.each do |currency|
      next if new_currencies.include? currency
      currencies.delete(currency)
    end
  end
end
