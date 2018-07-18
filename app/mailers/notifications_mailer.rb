class NotificationsMailer < ApplicationMailer
  def new_message(message)
    @message = message
    mail(to: message.receiver.email, subject: 'New message!')
  end
end