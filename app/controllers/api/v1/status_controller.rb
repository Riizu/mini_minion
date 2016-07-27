class Api::V1::StatusController < ApiBaseController
  def index
    @version = Status.first
    render json: @version
  end
end
