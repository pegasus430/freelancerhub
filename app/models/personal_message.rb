class PersonalMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  acts_as_list scope: :conversation

  validates :body, presence: true
  after_create :create_notifications

  after_create_commit do
    conversation.touch
    NotificationBroadcastJob.perform_later(self)
  end

  def create_notifications
    if User.find(user_id).is_employer == true
      Notification.create(recipient: User.find(conversation.author_id), sender: User.find(user_id), action: "posted", notifiable_type: "Conversation", notifiable_id: conversation.id)
    else
      Notification.create(recipient: User.find(conversation.receiver_id), sender: User.find(user_id), action: "posted", notifiable_type: "Conversation", notifiable_id: conversation.id)
    end
  end

  def receiver
    if conversation.author == conversation.receiver || conversation.receiver == user
      conversation.author
    else
      conversation.receiver
    end
  end
end