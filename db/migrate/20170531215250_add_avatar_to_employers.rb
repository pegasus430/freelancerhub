class AddAvatarToEmployers < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :employers, :avatar
  end

  def self.down
    remove_attachment :employers, :avatar
  end
end
