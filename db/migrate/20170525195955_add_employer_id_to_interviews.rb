class AddEmployerIdToInterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :interviews, :employer_id, :integer
  end
end
