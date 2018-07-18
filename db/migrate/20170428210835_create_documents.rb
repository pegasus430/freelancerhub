class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string     :file
      t.references :folder

      t.timestamps
    end
  end
end
