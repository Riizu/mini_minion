class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :region
      t.string :platform_id
      t.string :mode
      t.string :type
      t.integer :creation
      t.integer :duration
      t.string :queue_type
      t.integer :map_id
      t.string :season
      t.string :version
      t.string :participants
      t.string :blue_team
      t.string :red_team

      t.timestamps
    end
  end
end
