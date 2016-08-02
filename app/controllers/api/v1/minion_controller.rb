class Api::V1::MinionController < SecureApiBaseController
  def index
    render json: current_user.minion
  end

  def create
    current_user.update_attributes(status: :active)
    render json: Minion.create(name: params[:name], user: current_user)
  end
end
