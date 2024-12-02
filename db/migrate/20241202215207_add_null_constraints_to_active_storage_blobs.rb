class AddNullConstraintsToActiveStorageBlobs < ActiveRecord::Migration[7.1]
  def change
    change_column_null :active_storage_blobs, :content_type, false
    change_column_null :active_storage_blobs, :checksum, false
  end
end
