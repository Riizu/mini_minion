class ChangeMatchCreationToString < ActiveRecord::Migration[5.0]
  def change
    change_column :matches, :creation,  :string
  end
end
