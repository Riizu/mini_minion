class TokenController < ApplicationController
  def request_token
    redirect_to facebook_sign_in_url
  end

  def access_token
    user = User.login_with_facebook(params[:code])
    jwt = user.generate_jwt
    render json: jwt
  end

  private

  def facebook_sign_in_url
    "https://www.facebook.com/dialog/oauth?
      client_id=#{ENV['FACEBOOK_KEY']}&redirect_uri=#{ENV['FACEBOOK_CALLBACK']}"
  end
end
