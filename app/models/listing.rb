class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true

  has_many :currencies_listings
  has_many :currencies, through: :currencies_listings
  belongs_to :submitter, class_name: :User # , inverse_of: :user
end