class Location < ApplicationRecord
  validates_presence_of :name, :address
end
