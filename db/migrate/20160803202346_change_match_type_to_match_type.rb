class ChangeMatchTypeToMatchType < ActiveRecord::Migration[5.0]
  def change
    rename_column :matches, :type, :match_type
  end
end
