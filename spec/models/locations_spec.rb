require 'rails_helper'

describe Listing do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:submitter_id) }
end
