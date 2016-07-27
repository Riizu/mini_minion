require 'rails_helper'

describe "Status Endpoint" do
  it "Sends status information for the server" do
    status = create(:status, version: "0.0.1")

    get "/api/v1/status"

    expect(response).to be_success

    parsed_status = JSON.parse(response.body)

    expect(parsed_status["version"]).to eq "0.0.1"
    expect(parsed_status["last_update"]).to eq status.created_at
  end
end
