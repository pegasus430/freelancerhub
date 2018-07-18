class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  #def perform(personal_message)
  #  unless personal_message.user == personal_message.receiver
  #    ActionCable.server.broadcast "notifications_#{personal_message.user.id}_channel",
  #                                 message: render_message(personal_message),
  #                                 conversation_id: personal_message.conversation.id
  #  end
  #  if personal_message.receiver.online?
  #    ActionCable.server.broadcast "notifications_#{personal_message.receiver.id}_channel",
  #                                 notification: render_notification(personal_message),
  #                                 message: render_message(personal_message),
  #                                 conversation_id: personal_message.conversation.id
  #
  #   #author = private_message.user
  #   #receiver = private_message.conversation.opposed_user(author)
  #   #broadcast_to_sender(author, private_message)
  #   #broadcast_to_recipient(receiver, private_message)
  #  else
  #    NotificationsMailer.new_message(personal_message).deliver_now
  #  end
  #end

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private
  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast("notifications_#{user.id}_channel",
    message: render_mess(message, user), conversation_id: message.conversation.id)
  end 
  
  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast("notifications_#{user.id}_channel", 
    notification: render_notification(message),
    message: render_mess(message, user), 
    conversation_id: message.conversation.id)
  end 
  
  def render_mess(message, user)
    PersonalMessagesController.render partial: 'personal_messages/personal_message',
                                      locals: {personal_message: message, user: user}
  end

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: {message: message}
  end

  def render_message(message)
    PersonalMessagesController.render partial: 'personal_messages/personal_message',
                                      locals: {personal_message: message, user: message.user}
  end
end