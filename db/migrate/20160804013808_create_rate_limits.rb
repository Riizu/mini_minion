class CreateRateLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :rate_limits do |t|
      t.string :name
      t.string :limit
    end
  end
end
