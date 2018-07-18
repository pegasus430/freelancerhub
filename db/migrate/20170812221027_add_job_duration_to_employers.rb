class AddJobDurationToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :job_duration, :string
  end
end
