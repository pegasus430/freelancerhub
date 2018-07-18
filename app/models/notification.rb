class Notification < ApplicationRecord
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  
  scope :unread, ->{ where(read_at: nil) }
  scope :recent, ->{ order(created_at: :desc).limit(5) }
end
