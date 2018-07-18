class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.string :name

      t.references :folder
      t.references :conversation

      t.timestamps
    end

    #add_reference :conversations, :folder
  end
end
