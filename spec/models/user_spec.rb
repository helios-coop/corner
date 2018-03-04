require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:display_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }
  it { is_expected.to validate_uniqueness_of(:display_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:submissions) }
end
