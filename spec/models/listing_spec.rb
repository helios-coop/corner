# frozen_string_literal: true

require "rails_helper"

RSpec.describe Listing do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:submitter_id) }
  it { is_expected.to have_many(:currencies) }
  it { is_expected.to have_many(:categories) }
  it { is_expected.to belong_to(:submitter) }

  describe "uniqueness" do
    before { create(:listing, google_places_id: "abc123") }

    let(:satoshi) { users(:satoshi) }

    it do
      is_expected.to validate_uniqueness_of(:google_places_id).case_insensitive
    end
  end

  describe "search_by_name" do
    context "with partial search terms" do
      it "finds by partial word" do
        expect(described_class.search_by_name("Ether").count).to eq 1
      end

      it "finds by single word" do
        expect(described_class.search_by_name("cafe").count).to eq 2
      end
    end
  end

  describe "full_search" do
    context "when searched by name" do
      it do
        expect(described_class.full_search(name: "Litecoin").count).to eq 1
      end
    end

    context "when searched by location" do
    end

    context "when searched by category" do
    end
  end
end
