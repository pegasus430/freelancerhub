class AddAttachementToUploads < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :image_file_name, :string
    add_column :uploads, :image_content_type, :string
    add_column :uploads, :image_file_size, :integer
    add_column :uploads, :image_updated_at, :datetime
  end
end
