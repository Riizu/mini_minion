class User < ActiveRecord::Base
  validates_presence_of :uid, :name

  def self.facebook_service
    @@fb_service ||= FacebookService.new
  end

  def self.login_with_facebook(code)
    access_token = facebook_service.get_access_token(code)
    uid = facebook_service.get_uid(access_token)
    user_result = facebook_service.get_user(uid, access_token)
    User.find_or_create_by(uid: user_result["id"]) {|u| u.name = user_result["name"]}
  end
end
