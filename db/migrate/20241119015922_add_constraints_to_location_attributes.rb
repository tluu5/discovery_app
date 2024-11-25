class AddConstraintsToLocationAttributes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :location_attributes, :location_id, false
    change_column_null :location_attributes, :attribute_id, false
    add_index :location_attributes, [:location_id, :attribute_id], unique: true
  end
end
