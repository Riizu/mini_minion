require 'rails_helper'

describe "Minion Feed Endpoint" do
  it "feeds a minion", :vcr do
    user = create(:user, :with_summoner, :with_minion, last_match_pull: Time.new(2016,1,1))
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)
    user.minion.update_attributes(current_health: 75)

    get "/api/v1/minion/feed", headers: {'Authorization' => jwt}

    expect(response).to be_success

    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["current_health"]).to eq 100
  end
end
