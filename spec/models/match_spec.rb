require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should have_many(:summoners).through(:matchlists) }

  it "Should parse the output of a match service request", :vcr do
    ms = MatchService.new
    match_hash = ms.find_match(2082171522)

    result = Match.create_from_service(match_hash)
    stored_match = Match.first

    expect(result).to eq stored_match
    expect(stored_match.id).to eq result.id
    expect(stored_match.region).to eq result.region
    expect(stored_match.platform_id).to eq result.platform_id
    expect(stored_match.mode).to eq result.mode
    expect(stored_match.match_type).to eq result.match_type
    expect(stored_match.creation).to eq result.creation
    expect(stored_match.duration).to eq result.duration
    expect(stored_match.queue_type).to eq result.queue_type
    expect(stored_match.map_id).to eq result.map_id
    expect(stored_match.season).to eq result.season
    expect(stored_match.version).to eq result.version
    expect(stored_match.participants).to eq result.participants
    expect(stored_match.blue_team).to eq result.blue_team
    expect(stored_match.red_team).to eq result.red_team
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
