# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    name { Faker::Lorem.sentence }
    association :submitter, factory: :user
  end
end
