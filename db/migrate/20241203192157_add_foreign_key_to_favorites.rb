class AddForeignKeyToFavorites < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :favorites, :users, column: :user_id
    add_foreign_key :favorites, :locations, column: :location_id
  end
end
