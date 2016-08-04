class AddLastMatchPullToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_match_pull, :timestamp
  end
end
