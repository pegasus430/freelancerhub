class AddFilledToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :employer_status, :string
  end
end
