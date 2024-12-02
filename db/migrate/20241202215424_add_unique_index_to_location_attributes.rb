class AddUniqueIndexToLocationAttributes < ActiveRecord::Migration[7.1]
  def change
    remove_index :location_attributes, column: [:location_id, :feature_id], if_exists: true
    add_index :location_attributes, [:location_id, :feature_id], unique: true, name: "index_location_attributes_on_location_id_and_feature_id"
  end
end
