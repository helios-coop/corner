# frozen_string_literal: true

class User < ApplicationRecord
  validates :display_name, :email, :password_digest, presence: true
  validates :display_name, :email, uniqueness: true
  validates :password, length: { minimum: 8 }

  has_many :submissions,
           class_name: :Listing,
           foreign_key: :submitter_id,
           inverse_of: :submitter

  has_secure_password
end
