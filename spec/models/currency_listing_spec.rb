require 'rails_helper'

RSpec.describe CurrencyListing, type: :model do
  it { is_expected.to validate_presence_of(:currency_id) }
  it { is_expected.to validate_presence_of(:listing_id) }
  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:listing) }
end
