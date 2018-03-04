require 'rails_helper'

RSpec.describe Currency, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:symbol) }
  it { should have_many(:listings)}
end
