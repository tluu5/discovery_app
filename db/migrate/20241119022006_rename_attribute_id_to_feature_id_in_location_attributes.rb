class RenameAttributeIdToFeatureIdInLocationAttributes < ActiveRecord::Migration[7.1]
  def change
    rename_column :location_attributes, :attribute_id, :feature_id
  end
end
