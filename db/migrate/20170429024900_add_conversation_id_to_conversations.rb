class AddConversationIdToConversations < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :conversation, foreign_key: true
  end
end
