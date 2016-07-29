class Api::V1::CurrentUserController < ApiBaseController
  def index
    render json: current_user
  end
end
