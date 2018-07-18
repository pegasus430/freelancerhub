class CreateInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :interviews do |t|
      t.string :body
      t.string :title
      t.string :video_link
      t.string :job_requirement
      t.string :name
      t.string :email
      t.integer :user_id
      t.integer :conversation_id

      t.timestamps
    end
  end
end
