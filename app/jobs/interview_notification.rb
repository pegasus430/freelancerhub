class InterviewNotification < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)
    broadcast_to_recipient(recipient, message)
  end

  private
  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast("notifications_#{user.id}_channel",
    notification: render_notification(message),
    conversation_id: message.conversation.id)
  end

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: {message: message}
  end
end