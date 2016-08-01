require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should have_many(:summoners).through(:matchlists) }

  it "Should have an array of participants" do
    match = create(:match)

    participants = match.participants

    expect(participants[0].class).to eq Participant
    expect(participants[0].stats.class).to eq Stats
    expect(participants[0].timeline.class).to eq Timeline
  end

  it "Should have blue team stats" do
    match = create(:match)

    blue_team = match.blue_team

    expect(blue_team.class).to eq Team
  end

  it "Should have red team stats" do
    match = create(:match)

    red_team = match.red_team

    expect(red_team.class).to eq Team
  end
end
