class SecureApiBaseController < ApiBaseController
  before_action :authenticate_request

  def current_user
    @current_user
  end

  private

  def authenticate_request
    begin
      uid = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base)[0]['uid']
      @current_user = User.find_by(uid: uid)
    rescue JWT::DecodeError
      render json: {error: 'authentication failed', status: 401}
    end
  end
end
