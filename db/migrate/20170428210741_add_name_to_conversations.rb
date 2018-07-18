class AddNameToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :name, :string
    add_column :conversations, :folder_id, :integer
  end
end
