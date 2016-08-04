class Api::V1::Minion::UpdateController < SecureApiBaseController
  def index
    render json: current_user.update_minion
  end
end
