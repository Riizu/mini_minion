class ChangeMatchDurationToString < ActiveRecord::Migration[5.0]
  def change
    change_column :matches, :duration,  :string
  end
end
