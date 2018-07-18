class AddContentToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :content, :string
  end
end
