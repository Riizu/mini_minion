class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
    add_index :users, :uid
  end
end
