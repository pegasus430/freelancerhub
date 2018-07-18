class AddSocialToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :facebook, :string
    add_column :employers, :instagram, :string
    add_column :employers, :company_website, :string
    add_column :employers, :linkedin, :string
    add_column :employers, :additional_link, :string
  end
end
