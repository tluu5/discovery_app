class ChangeCityStateZipCodeToNotNull < ActiveRecord::Migration[7.1]
  def up
    # Update any existing NULL values with default values
    Location.where(city: nil).update_all(city: 'Unknown')
    Location.where(state: nil).update_all(state: 'XX')
    Location.where(zip_code: nil).update_all(zip_code: '00000')

    # Now add the NOT NULL constraint
    change_column_null :locations, :city, false
    change_column_null :locations, :state, false
    change_column_null :locations, :zip_code, false
  end

  def down
    # Revert the NOT NULL constraint
    change_column_null :locations, :city, true
    change_column_null :locations, :state, true
    change_column_null :locations, :zip_code, true
  end
end
