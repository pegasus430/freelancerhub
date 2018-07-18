class AddStudentIdToInterview < ActiveRecord::Migration[5.0]
  def change
    add_column :interviews, :student_id, :integer
  end
end
