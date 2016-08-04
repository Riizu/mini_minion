require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:last_match_pull) }

  it { should have_one(:minion) }
  it { should have_one(:summoner) }

  it { should define_enum_for(:status).with([:registered, :active, :banned, :inactive]) }

  it "Should validate uniqueness of uid" do
    create(:user)
    should validate_uniqueness_of(:uid).case_insensitive
  end

  it "has a Facebook Service" do
    expect(User.facebook_service.class).to eq FacebookService
  end

  it "generates a JWT" do
    user = create(:user)
    jwt = user.generate_jwt
    uid = JWT.decode(jwt, Rails.application.secrets.secret_key_base)[0]['uid']

    expect(uid).to eq user.uid
  end

  it "logs a user into facebook" do
    allow_any_instance_of(FacebookService).to receive(:get_uid).and_return("1")
    allow_any_instance_of(FacebookService).to receive(:get_user).and_return( {"id" => "1", "name" => "test"} )
    example_access_token = "12415iwefjsldkfhajshr23p5io;klj;alkdf"

    user = User.login_with_facebook(example_access_token)
    user_last_match_pull = user.last_match_pull.strftime("%Y%m%d")
    expected_match_pull = Time.now.strftime("%Y%m%d")

    user_last_match_pull = user.last_match_pull.strftime("%Y%m%d")
    expected_match_pull = Time.new(2016,8,4).strftime("%Y%m%d")

    expect(user).to eq User.first
    expect(user.uid).to eq ("1")
    expect(user.name).to eq ("test")
    expect(user_last_match_pull).to eq expected_match_pull
  end

  it "finds ranked matchlists that are after the last_match_pull date", :vcr do
    user = create(:user, :with_summoner, last_match_pull: Time.new(2016, 1, 1))

    results = user.get_ranked_matchlist

    expect(results.count).to eq 1
    expect(results[0]["matchId"]).to eq 2082171522
  end

  it "finds matches after the last_match_pull date", :vcr do
    user = create(:user, :with_summoner, last_match_pull: Time.new(2016, 1, 1))

    results = user.get_matches
    stored_match = user.summoner.matches.first


    expect(results.count).to eq 1
    expect(results[0].id).to eq 2082171522
    expect(stored_match.id).to eq 2082171522
  end

  it "updates last_match_pull after finding matches", :vcr do
    user = create(:user, :with_summoner, last_match_pull: Time.new(2016, 1, 1))

    user.get_matches
    actual_match_pull = user.last_match_pull.strftime("%Y%m%d")
    expected_match_pull = Time.new(2016,8,4).strftime("%Y%m%d")

    expect(actual_match_pull).to eq expected_match_pull
  end
end
