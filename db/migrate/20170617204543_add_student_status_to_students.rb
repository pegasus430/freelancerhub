class AddStudentStatusToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :student_status, :string
  end
end
