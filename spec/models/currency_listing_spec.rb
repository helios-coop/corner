require 'rails_helper'

RSpec.describe CurrencyListing, type: :model do
  it { should validate_presence_of(:currency_id) }
  it { should validate_presence_of(:listing_id) }
  it { should belong_to(:currency) }
  it { should belong_to(:listing) }
end
