class AddDefaultValueToStatusForUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :status
    add_column :users, :status, :integer, default: 0
  end
end
