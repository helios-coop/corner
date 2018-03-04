class Currency < ApplicationRecord
  validates :name, :symbol, presence: true
end
