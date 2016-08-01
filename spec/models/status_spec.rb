require 'rails_helper'

RSpec.describe Status, type: :model do
  it { should validate_presence_of(:version) }
  it { should validate_uniqueness_of(:version) }
end
