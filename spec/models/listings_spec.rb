require 'rails_helper'

describe Listing do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:submitter_id) }
  it { should have_many(:currencies) }
  it { should belong_to(:submitter) }
end
