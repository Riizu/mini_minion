require 'rails_helper'

RSpec.describe MatchService do
  it "can pull a ranked match list for a given summoner", :vcr do
    ms = MatchService.new
    time = Time.new(2016, 1, 1)

    matchlist = ms.find_ranked_matchlist(20257398, time)
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

  it "can pull a ranked match by match ID", :vcr do
    ms = MatchService.new

    match = ms.find_ranked_match(2082171522)

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
    expect(match["blue_team"]).to eq ({"teamId" => 100,"winner" => false,"firstBlood" => true,"firstTower" => true,"firstInhibitor" => false,"firstBaron" => false,"firstDragon" => false,"firstRiftHerald" => true,"towerKills" => 2,"inhibitorKills" => 0,"baronKills" => 0,"dragonKills" => 0,"riftHeraldKills" => 1,"vilemawKills" => 0,"dominionVictoryScore" => 0})
    expect(match["red_team"]).to eq ({"teamId" => 200,"winner" => true,"firstBlood" => false,"firstTower" => false,"firstInhibitor" => false,"firstBaron" => false,"firstDragon" => true,"firstRiftHerald" => false,"towerKills" => 5,"inhibitorKills" => 0,"baronKills" => 0,"dragonKills" => 3,"riftHeraldKills" => 0,"vilemawKills" => 0,"dominionVictoryScore" => 0})
  end

  it "updates the rate limit after a call", :vcr do
    ms = MatchService.new
    time = Time.new(2016, 1, 1)

    ms.find_ranked_matchlist(20257398, time)
    rate_limit_entry = RateLimit.find_by_name("riot")

    expect(rate_limit_entry.limit).to eq "1:10,1:600"
  end

  it "updates the rate limit after multiple calls", :vcr do
    ms = MatchService.new
    time = Time.new(2016, 1, 1)

    ms.find_ranked_matchlist(20257398, time)
    ms.find_ranked_matchlist(20257398, time)
    ms.find_ranked_matchlist(20257398, time)
    ms.find_ranked_matchlist(20257398, time)
    rate_limit_entry = RateLimit.find_by_name("riot")

    expect(rate_limit_entry.limit).to eq "4:10,4:600"
  end

  it "checks rate limit prior to calls, preventing a call when at limit", :vcr do
    ms = MatchService.new
    time = Time.new(2016, 1, 1)
    create(:rate_limit, name: "riot", limit: "8:10,8:600")

    ms.find_ranked_matchlist(20257398, time)
    rate_limit_entry = RateLimit.find_by_name("riot")

    expect(rate_limit_entry.limit).to eq "1:10,9:600"
  end

  it "checks rate limit across calls", :vcr do
    ms = MatchService.new
    time = Time.new(2016, 1, 1)
    create(:rate_limit, name: "riot", limit: "6:10,6:600")

    ms.find_ranked_matchlist(20257398, time)
    rate_limit_entry_1 = RateLimit.find_by_name("riot")

    expect(rate_limit_entry_1.limit).to eq "7:10,7:600"

    ms.find_ranked_match(2082171522)
    rate_limit_entry_2 = RateLimit.find_by_name("riot")

    expect(rate_limit_entry_2.limit).to eq "1:10,8:600"
  end
end
