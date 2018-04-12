# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    display_name { Faker::DragonBall.character }
    email { Faker::Internet.email }
    password "blahblah"
    password_confirmation "blahblah"
    role "user"
  end
end
