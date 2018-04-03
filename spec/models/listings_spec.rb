# frozen_string_literal: true

require "rails_helper"

RSpec.describe Listing do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:submitter_id) }
  it { is_expected.to have_many(:currencies) }
  it { is_expected.to belong_to(:submitter) }

  describe "uniqueness" do
    subject { described_class.new(name: "Satoshi Cafe", submitter_id: satoshi.id, google_places_id: "12345") }

    let(:satoshi) { users(:satoshi) }

    it { is_expected.to validate_uniqueness_of(:google_places_id).case_insensitive }
  end
end
