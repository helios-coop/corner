class Location < ApplicationRecord
  validates :name, :address, presence: true
end
