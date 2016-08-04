require 'rails_helper'

describe "Minion Update Endpoint" do
  it "updates a minion and returns the new minon", :vcr do
    user = create(:user, :with_summoner, :with_minion, last_match_pull: Time.new(2016,1,1))
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)

    get "/api/v1/minion/update", headers: {'Authorization' => jwt}

    expect(response).to be_success

    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["xp"]).to eq 1000
  end

  it "updates accurately with changes", :vcr do
    user = create(:user, :with_summoner, :with_minion, last_match_pull: Time.new(2016,1,1))
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)

    get "/api/v1/minion/update", headers: {'Authorization' => jwt}
    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["xp"]).to eq 1000

    user.minion.update_attributes(last_ate: Time.new(2016, 1, 1))
    user.update_attributes(last_match_pull: Time.new(2016, 8, 4))
    get "/api/v1/minion/update", headers: {'Authorization' => jwt}
    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["xp"]).to eq 1000
    expect(parsed_minion["current_happiness"]).to eq 80
  end
end
