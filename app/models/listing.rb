class Listing < ApplicationRecord
  validates :name, :submitter_id, presence: true
end
