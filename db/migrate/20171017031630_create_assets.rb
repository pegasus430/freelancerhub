class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string    :type
      t.integer   :assetable_id
      t.string    :assetable_type
      t.string    :attachment_file_name
      t.string    :attachment_type
      t.integer   :attachment_file_size
      t.datetime  :attachment_updated_at

      t.timestamps
    end
  end
end
