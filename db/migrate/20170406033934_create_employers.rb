class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :title
      t.string :name
      t.integer :user_id
      t.string :link
      t.string :description

      t.timestamps null: false
    end
  end
end
