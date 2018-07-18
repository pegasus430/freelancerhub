class AddDatesToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :date_start, :string
    add_column :works, :date_end, :string
  end
end
