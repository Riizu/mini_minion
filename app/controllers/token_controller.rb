class TokenController < ApplicationController
  def request_token
    redirect_to facebook_sign_in
  end

  def access_token
    user = User.login_with_facebook(params[:code])
    render text: user.name
    #----BEGIN REACT NATIVE CONTENT-----#
    #generate 1-day jwt using UID & secret_key_base
    #return JWT to app for sign verification
  end

  private

  def facebook_sign_in
    "https://www.facebook.com/dialog/oauth?
      client_id=#{ENV['FACEBOOK_KEY']}&redirect_uri=#{ENV['FACEBOOK_CALLBACK']}"
  end
end
