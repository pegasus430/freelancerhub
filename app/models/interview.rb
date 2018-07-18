class Interview < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :student,  foreign_key: :student_id, class_name: 'User'
  belongs_to :employer, foreign_key: :employer_id
  belongs_to :conversation

  after_update :create_notifications

  after_update_commit do
    conversation.touch
    InterviewNotification.perform_later(self)
  end

  def create_notifications
    if User.find(user_id).is_employer == true
      Notification.create(recipient: User.find(conversation.receiver_id),
                          sender: User.find(user_id),
                          action: "posted", notifiable_type: "Job",
                          notifiable_id: conversation.id)
    else
      Notification.create(recipient: User.find(conversation.author_id),
                          sender: User.find(user_id),
                          action: "posted", notifiable_type: "Job",
                          notifiable_id: conversation.id)
    end
  end
end
