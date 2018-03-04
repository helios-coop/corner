class User < ApplicationRecord
  validates :display_name, :email, :password_digest, presence: true

  has_many :submissions, class_name: :Listing, foreign_key: :submitter_id # , inverse_of: :listing
end
