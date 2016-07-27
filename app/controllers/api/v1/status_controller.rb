class Api::V1::StatusController < ApiBaseController
  def index
    @version = Status.order(created_at: :desc).first
    render json: @version
  end
end
