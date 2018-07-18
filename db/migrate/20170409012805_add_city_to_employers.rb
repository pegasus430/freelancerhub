class AddCityToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :city, :string
    add_column :employers, :state, :string
    add_column :employers, :pay, :string
  end
end
