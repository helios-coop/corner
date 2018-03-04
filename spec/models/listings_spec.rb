require 'rails_helper'

RSpec.describe Listing, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:submitter_id) }
  it { should have_many(:currencies) }
end
