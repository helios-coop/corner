# frozen_string_literal: true

require "rails_helper"

RSpec.describe Listing do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:submitter_id) }
  it { is_expected.to have_many(:currencies) }
  it { is_expected.to belong_to(:submitter) }

  describe "uniqueness" do
    before { create(:listing, google_places_id: "abc123") }

    let(:satoshi) { users(:satoshi) }

    it do
      is_expected.to validate_uniqueness_of(:google_places_id).case_insensitive
    end
  end
end
