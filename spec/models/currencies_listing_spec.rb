# frozen_string_literal: true

require "rails_helper"

RSpec.describe CurrenciesListing, type: :model do
  it { is_expected.to validate_presence_of(:currency_id) }
  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:listing) }
end
