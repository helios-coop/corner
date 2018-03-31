# frozen_string_literal: true

CURRENCIES = [
  { name: 'Bitcoin', symbol: 'BTC' },
  { name: 'Litecoin', symbol: 'LTC' },
  { name: 'Bitcoin Cash', symbol: 'BCH' },
  { name: 'Etherium', symbol: 'ETH' },
  { name: 'Tron', symbol: 'TRX' }
].freeze

FactoryBot.define do
  factory :currency do
    sequence(:name) { |n| CURRENCIES[n][:name] }
    sequence(:symbol) { |n| CURRENCIES[n][:symbol] }
  end
end
