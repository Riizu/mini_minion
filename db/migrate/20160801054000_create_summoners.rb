class CreateSummoners < ActiveRecord::Migration[5.0]
  def change
    create_table :summoners do |t|
      t.string :name
      t.integer :profile_icon_id
      t.integer :level

      t.timestamps
    end
  end
end
