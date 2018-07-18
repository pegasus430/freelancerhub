class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.string :company_name
      t.string :position
      t.datetime :date_from
      t.datetime :date_to
      t.string :description
      t.string :city
      t.string :state
      t.string :country
      t.integer :user_id
      t.timestamps
    end
  end
end
