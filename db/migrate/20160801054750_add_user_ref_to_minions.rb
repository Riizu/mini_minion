class AddUserRefToMinions < ActiveRecord::Migration[5.0]
  def change
    add_reference :minions, :user, foreign_key: true
  end
end
