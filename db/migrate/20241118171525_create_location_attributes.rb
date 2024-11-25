class CreateLocationAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :location_attributes do |t|
      t.integer :location_id
      t.integer :attribute_id

      t.timestamps
    end
  end
end
