class AddAvatarToStudents < ActiveRecord::Migration[5.0]
   def self.up
    add_attachment :students, :avatar
  end

  def self.down
    remove_attachment :students, :avatar
  end
end
