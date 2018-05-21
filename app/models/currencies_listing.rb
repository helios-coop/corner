# frozen_string_literal: true

class CurrenciesListing < ApplicationRecord
  acts_as_paranoid

  validates :currency_id, presence: true

  belongs_to :currency
  belongs_to :listing
end
