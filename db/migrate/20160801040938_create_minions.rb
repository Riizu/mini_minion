class CreateMinions < ActiveRecord::Migration[5.0]
  def change
    create_table :minions do |t|
      t.string :name
      t.integer :level, default: 1
      t.integer :xp, default: 0
      t.integer :current_health, default: 150
      t.integer :current_stamina, default: 100
      t.integer :current_happiness, default: 100
      t.integer :total_health, default: 150
      t.integer :total_stamina, default: 100
      t.integer :total_happiness, default: 100
      t.timestamp :last_ate, default: Time.now
    end
  end
end
