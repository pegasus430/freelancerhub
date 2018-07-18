class AddApplyToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :title, :string
    add_column :conversations, :video_link, :string
    add_column :conversations, :job_requirement, :string
  end
end
