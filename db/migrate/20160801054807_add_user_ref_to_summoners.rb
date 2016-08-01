class AddUserRefToSummoners < ActiveRecord::Migration[5.0]
  def change
    add_reference :summoners, :user, foreign_key: true
  end
end
