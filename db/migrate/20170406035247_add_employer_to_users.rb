class AddEmployerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_employer, :boolean
    add_column :users, :is_student, :boolean
    add_column :users, :is_admin, :boolean
  end
end
