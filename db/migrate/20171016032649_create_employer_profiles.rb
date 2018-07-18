class CreateEmployerProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :employer_profiles do |t|
      t.integer  :user_id,            null: false
      t.string   :slug,               unique: true
      t.string   :company_name
      t.text     :company_descripion
      t.string   :website
      t.string   :facebook
      t.string   :twitter
      t.string   :linkedin
      t.string   :instagram

      t.timestamps
    end
  end
end
