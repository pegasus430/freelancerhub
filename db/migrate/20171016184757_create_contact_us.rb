class CreateContactUs < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_us do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :company_name
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end