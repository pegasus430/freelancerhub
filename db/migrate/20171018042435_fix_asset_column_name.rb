class FixAssetColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :assets , :attachment_type, :attachment_content_type
  end
end
