require 'rails_helper'

RSpec.describe RiotService, :vcr do
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


  it "returns a new rate limit object if none exist" do
    rs = RiotService.new
    limit_entry = rs.get_limit_entry

    expect(limit_entry.class).to eq RateLimit
    expect(limit_entry.name).to eq "riot"
    expect(limit_entry.limit).to eq "1:10,1:600"
  end

  it "returns an existing rate limit object if present" do
    existing_limit_entry = create(:rate_limit, name: "riot", limit: "2:10, 25:600")

    rs = RiotService.new
    limit_entry = rs.get_limit_entry

    expect(limit_entry.class).to eq RateLimit
    expect(limit_entry.name).to eq existing_limit_entry.name
    expect(limit_entry.limit).to eq existing_limit_entry.limit
  end

  it "determines if its within limits when a limit exists" do
    rs = RiotService.new
    result = rs.handle_limits

    expect(result).to eq nil
  end

  it "determines if its at limits when a limit exists" do
    rs = RiotService.new
    create(:rate_limit, name: "riot", limit: "2:10,590:600")
    result = rs.handle_limits

    expect(result).to eq true
  end

  it "updates rate limits when no limit entry exists" do
    rs = RiotService.new
    rs.update_rate_limit("1:10,1:600")

    rate_limit = RateLimit.find_by_name("riot")

    expect(rate_limit.limit).to eq "1:10,1:600"
  end

  it "updates rate limits multiple times" do
    rs = RiotService.new
    rs.update_rate_limit("1:10,1:600")
    rs.update_rate_limit("2:10,2:600")

    rate_limit = RateLimit.find_by_name("riot")

    expect(rate_limit.limit).to eq "2:10,2:600"
  end
end
