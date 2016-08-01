class Api::V1::CurrentUserController < SecureApiBaseController
  def index
    render json: current_user
  end
end
