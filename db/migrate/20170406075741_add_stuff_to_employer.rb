class AddStuffToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :category, :string
    add_column :employers, :responsibility, :string
    add_column :employers, :requirement, :string
    add_column :employers, :work_schedule, :string
    add_column :employers, :diploma, :string
    add_column :employers, :written_languages,  :string
    add_column :employers, :spoken_languages, :string
    add_column :employers, :level_of_study, :string
    add_column :employers, :zip_code, :string
    add_column :employers, :start_date, :datetime
    add_column :employers, :url, :string
    add_column :employers, :image_url, :string
  end
end
