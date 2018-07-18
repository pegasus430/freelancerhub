class CreateStudentProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :student_profiles do |t|
      t.integer       :user_id,    null: false
      t.string        :slug,       unique: true 
      t.string        :eduction
      t.text          :description
      t.string        :location
      t.string        :website
      t.integer       :age
      t.string        :phone
      t.string        :facebook
      t.string        :linkedin
      t.string        :twitter
      t.string        :instagram

      t.timestamps
    end
  end
end
