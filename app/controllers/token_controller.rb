class TokenController < ApplicationController
  def access_token
    user = User.login_with_facebook(params[:code])
    jwt = user.generate_jwt
    render json: {jwt: jwt}
  end
end
