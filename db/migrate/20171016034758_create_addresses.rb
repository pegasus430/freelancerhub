class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer   :addressable_id ,  null: false
      t.string    :addressable_type, null: false
      t.string    :email
      t.text      :address           
      t.string    :landline
      t.string    :mobile
      t.string    :latitude
      t.string    :longitude

      t.timestamps
    end
  end
end
