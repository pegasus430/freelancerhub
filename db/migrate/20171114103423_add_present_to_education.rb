class AddPresentToEducation < ActiveRecord::Migration[5.0]
  def change
    add_column :educations, :present, :string
  end
end
