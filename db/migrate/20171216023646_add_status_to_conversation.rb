class AddStatusToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :status, :string  , default: 'pending'
  end
end
