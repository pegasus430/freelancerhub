class AddExperienceToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :years_of_experience, :string
  end
end
