require 'rails_helper'

describe "Minion Endpoint" do
  it "returns the minion for the current user", :vcr do
    user = create(:user, :with_minion)
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)

    get "/api/v1/minion", headers: {'Authorization' => jwt}

    expect(response).to be_success

    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["name"]).to eq user.minion.name
    expect(parsed_minion["level"]).to eq user.minion.level
    expect(parsed_minion["xp"]).to eq user.minion.xp
    expect(parsed_minion["current_health"]).to eq user.minion.current_health
    expect(parsed_minion["current_stamina"]).to eq user.minion.current_stamina
    expect(parsed_minion["current_happiness"]).to eq user.minion.current_happiness
    expect(parsed_minion["total_health"]).to eq user.minion.total_health
    expect(parsed_minion["total_stamina"]).to eq user.minion.total_stamina
    expect(parsed_minion["total_happiness"]).to eq user.minion.total_happiness
    expect(parsed_minion["last_ate"]).to eq user.minion.last_ate.to_s
    expect(parsed_minion["user_id"]).to eq nil
  end

  it "returns the minion for the current user", :vcr do
    user = create(:user)
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)

    post "/api/v1/minion", headers: {'Authorization' => jwt},
                           params: {name: "Test"}

    expect(response).to be_success

    parsed_minion = JSON.parse(response.body)

    expect(parsed_minion["name"]).to eq "Test"
    expect(user.minion.name).to eq "Test"
  end
end
