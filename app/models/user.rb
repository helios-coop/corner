class User < ApplicationRecord
  validates :display_name, :email, :password_digest, presence: true
  validates :display_name, :email, uniqueness: true
  has_many :submissions, class_name: :Listing, foreign_key: :submitter_id # inverse_of: :listing
  has_secure_password
end
