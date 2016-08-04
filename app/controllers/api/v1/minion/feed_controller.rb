class Api::V1::Minion::FeedController < SecureApiBaseController
  def index
    current_user.minion.take_action(:eat_poro_snack)
    render json: current_user.minion
  end
end
