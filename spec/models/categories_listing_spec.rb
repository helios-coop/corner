# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoriesListing, type: :model do
  it { is_expected.to validate_presence_of(:category_id) }
  it { is_expected.to validate_presence_of(:listing_id) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:listing) }
end
