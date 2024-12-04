class AddForeignKeyToLocationAttributes < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :location_attributes, :locations, column: :location_id
    add_foreign_key :location_attributes, :attributes, column: :feature_id
  end
end
