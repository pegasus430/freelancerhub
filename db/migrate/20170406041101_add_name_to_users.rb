class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company_name, :string
    add_column :users, :full_name, :string
    add_column :users, :postal_code, :string
    add_column :users, :age, :integer
  end
end
