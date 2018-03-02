require 'rails_helper'

describe Location do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
end
