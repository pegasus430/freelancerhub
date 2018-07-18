class AddPlaceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :location, :string
    add_column :users, :website, :string
    add_column :users, :phone, :string
    add_column :users, :education, :string
  end
end
