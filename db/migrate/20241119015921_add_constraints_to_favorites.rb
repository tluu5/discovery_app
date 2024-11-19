class AddConstraintsToFavorites < ActiveRecord::Migration[7.1]
  def change
    change_column_null :favorites, :user_id, false
    change_column_null :favorites, :location_id, false
    add_index :favorites, [:user_id, :location_id], unique: true
  end
end
