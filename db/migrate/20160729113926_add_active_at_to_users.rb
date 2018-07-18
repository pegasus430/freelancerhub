class AddActiveAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_at, :datetime, default: 5.years.ago
  end
end
