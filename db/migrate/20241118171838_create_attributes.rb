class CreateAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :attributes do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
