class AddConstraintsToAttributes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :attributes, :name, false
    change_column_null :attributes, :category, false
    add_index :attributes, :name, unique: true
  end
end
