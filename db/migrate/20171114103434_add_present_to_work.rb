class AddPresentToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :present, :string
  end
end
