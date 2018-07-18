class AddPayToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :pay, :string
  end
end
