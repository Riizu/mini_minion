class Api::V1::MinionController < SecureApiBaseController
  def index
    render json: current_user.minion
  end
end
