class AddDatesToEducation < ActiveRecord::Migration[5.0]
  def change
    add_column :educations, :date_start, :string
    add_column :educations, :date_end, :string
  end
end
