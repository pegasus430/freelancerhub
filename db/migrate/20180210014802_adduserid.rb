class Adduserid < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :awarded_student_id, :integer
  end
end
