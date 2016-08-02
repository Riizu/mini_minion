class CreateJoinTableSummonerMatch < ActiveRecord::Migration[5.0]
  def change
    create_table 'matchlists', :id => false do |t|
    t.column :summoner_id, :integer
    t.column :match_id, :integer
  end
  end
end
