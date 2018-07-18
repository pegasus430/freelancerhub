class AddStatusToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :status, :string
  end
end
