require 'rails_helper'

describe "Current User Endpoint" do
  it "returns a current user if authorized" do
    user = create(:user)
    jwt = JWT.encode({uid: user.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)

    get "/api/v1/current_user", headers: {'Authorization' => jwt}

    expect(response).to be_success

    parsed_current_user = JSON.parse(response.body)

    expect(parsed_current_user["name"]).to eq user.name
    expect(parsed_current_user["uid"]).to eq user.uid
  end
end
