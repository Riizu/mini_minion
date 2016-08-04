class MinionUpdateWorker
  include Sidekiq::Worker

  def perform(current_user_id)
    user = User.find(current_user_id)
    user.update_minion
  end
end
