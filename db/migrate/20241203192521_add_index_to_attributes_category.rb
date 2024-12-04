class AddIndexToAttributesCategory < ActiveRecord::Migration[7.1]
  def change
    add_index :attributes, :category
  end
end
