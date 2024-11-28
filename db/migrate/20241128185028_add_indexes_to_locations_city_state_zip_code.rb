class AddIndexesToLocationsCityStateZipCode < ActiveRecord::Migration[7.1]
  def change
    add_index :locations, :city
    add_index :locations, :state
    add_index :locations, :zip_code
  end
end
