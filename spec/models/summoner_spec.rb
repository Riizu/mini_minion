require 'rails_helper'

RSpec.describe Summoner, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:profile_icon_id) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:user_id) }

  it { should validate_uniqueness_of(:name) }

  it { should have_many(:matches).through(:matchlists) }
end
