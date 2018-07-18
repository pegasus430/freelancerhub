class RenameEducationToStudentProfile < ActiveRecord::Migration[5.0]
  def change
     rename_column :student_profiles , :eduction, :education
  end
end
