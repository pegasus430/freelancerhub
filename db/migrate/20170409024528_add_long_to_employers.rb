class AddLongToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :long_description, :string
  end
end
