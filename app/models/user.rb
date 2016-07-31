class User < ActiveRecord::Base
  validates_presence_of :uid, :name

  def self.facebook_service
    @@fb_service ||= FacebookService.new
  end

  def self.login_with_facebook(access_token)
    uid = facebook_service.get_uid(access_token)
    user_result = facebook_service.get_user(uid, access_token)
    User.find_or_create_by(uid: user_result["id"]) {|u| u.name = user_result["name"]}
  end

  def generate_jwt
    JWT.encode({uid: self.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)
  end
end
