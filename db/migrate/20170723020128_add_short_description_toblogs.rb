class AddShortDescriptionToblogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :short_description, :string
  end
end
