class ChangeLatitudeAndLongitudeToFloatInLocations < ActiveRecord::Migration[7.1]
  def change
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float
  end
end
