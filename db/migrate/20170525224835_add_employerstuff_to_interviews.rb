class AddEmployerstuffToInterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :interviews, :employer_name, :string
    add_column :interviews, :employer_title, :string
    add_column :interviews, :employer_description, :string
    add_column :interviews, :employer_additional, :string
  end
end
