require 'rails_helper'

RSpec.describe RateLimit, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:limit) }
end
