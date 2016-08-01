require 'rails_helper'

RSpec.describe SummonerService, :vcr => { :cassette_name => "summoner" } do
  it "can pull a single summoner's data" do
    ss = SummonerService.new

    summoners = ss.find_summoners("Riizu")
    riizu = summoners["riizu"]

    expect(riizu["id"]).to eq 20257398
    expect(riizu["name"]).to eq "Riizu"
    expect(riizu["profileIconId"]).to eq 780
    expect(riizu["summonerLevel"]).to eq  30
  end
end
