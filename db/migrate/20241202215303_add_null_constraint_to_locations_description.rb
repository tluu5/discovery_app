class AddNullConstraintToLocationsDescription < ActiveRecord::Migration[7.1]
  def change
    change_column_null :locations, :description, false
  end
end
