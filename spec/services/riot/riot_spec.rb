require 'rails_helper'

RSpec.describe RiotService, :vcr => { :cassette_name => "riot" } do
  it "has a base connection" do
    rs = RiotService.new
    url_prefix = rs.connection.url_prefix.to_s
    api_key = rs.connection.params["api_key"]

    expect(url_prefix).to eq "https://na.api.pvp.net/api/lol/"
    expect(api_key).to eq ENV["RIOT_API"]
  end

  it "can pull game version data" do
    rs = RiotService.new

    versions = rs.versions

    expect(versions).to include("6.15.1")
  end
end
