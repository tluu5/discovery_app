class AddConstraintsToLocations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :locations, :name, false
    change_column_null :locations, :address, false
    change_column_null :locations, :latitude, false
    change_column_null :locations, :longitude, false
    add_index :locations, :name, unique: true
  end
end
