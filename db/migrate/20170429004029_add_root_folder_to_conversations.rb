class AddRootFolderToConversations < ActiveRecord::Migration[5.0]
  def change
    Conversation.find_each do |p|
      p.create_folder!(name: p.name, conversation: p) unless p.folder
    end
  end
end
