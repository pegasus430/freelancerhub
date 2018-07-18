class AddStuffToStudents < ActiveRecord::Migration
  def change
    add_column :students, :category, :string
    add_column :students, :responsibility, :string
    add_column :students, :requirement, :string
    add_column :students, :salary, :string
    add_column :students, :work_schedule, :string
    add_column :students, :internship_report, :string
    add_column :students, :company_size, :string
    add_column :students, :diploma, :string
    add_column :students, :written_languages,  :string
    add_column :students, :spoken_languages, :string
    add_column :students, :level_of_study, :string
    add_column :students, :zip_code, :string
    add_column :students, :start_date, :datetime
    add_column :students, :url, :string
    add_column :students, :image_url, :string
  end
end
