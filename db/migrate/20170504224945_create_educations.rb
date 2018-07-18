class CreateEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :educations do |t|
      t.string :degree
      t.string :degree_type
      t.string :degree_major
      t.string :school_name
      t.datetime :date_from
      t.datetime :date_to
      t.string :description
      t.integer :user_id
      t.integer :student_id

      t.timestamps
    end
  end
end
