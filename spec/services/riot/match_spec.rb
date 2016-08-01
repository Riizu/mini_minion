require 'rails_helper'

RSpec.describe MatchService do
  it "can pull a match list for a given summoner", :vcr => { :cassette_name => "match_list" } do
    ms = MatchService.new

    matchlist = ms.find_matchlist(20257398)
    first_match = matchlist[0]

    expect(first_match["region"]).to eq "NA"
    expect(first_match["platformId"]).to eq "NA1"
    expect(first_match["matchId"]).to eq 2082171522
    expect(first_match["champion"]).to eq 33
    expect(first_match["queue"]).to eq "TEAM_BUILDER_DRAFT_RANKED_5x5"
    expect(first_match["season"]).to eq "SEASON2016"
    expect(first_match["timestamp"]).to eq 1454047672406
    expect(first_match["lane"]).to eq "JUNGLE"
    expect(first_match["role"]).to eq "NONE"
  end

  it "can pull a match by match ID", :vcr => { :cassette_name => "match" } do
    ms = MatchService.new

    match = ms.find_match(2082171522)

    expect(match["matchId"]).to eq 2082171522
    expect(match["region"]).to eq "NA"
    expect(match["platformId"]).to eq "NA1"
    expect(match["matchMode"]).to eq "CLASSIC"
    expect(match["matchType"]).to eq "MATCHED_GAME"
    expect(match["matchCreation"]).to eq 1454047672406
    expect(match["matchDuration"]).to eq 1495
    expect(match["queueType"]).to eq "TEAM_BUILDER_DRAFT_RANKED_5x5"
    expect(match["mapId"]).to eq 11
    expect(match["season"]).to eq "SEASON2016"
    expect(match["matchVersion"]).to eq "6.2.0.238"
    expect(match["participants"].count).to eq 10
    expect(match["participantIdentities"].count).to eq 10
    expect(match["teams"].count).to eq 2
  end
end
