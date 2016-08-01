require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:summoner_id) }
  it { should validate_presence_of(:minion_id) }

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

    expect(user.uid).to eq ("1")
    expect(user.name).to eq ("test")
  end
end
