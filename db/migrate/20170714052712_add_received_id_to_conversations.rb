class AddReceivedIdToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :received_id, :integer
  end
end
