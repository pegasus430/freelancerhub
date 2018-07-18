# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{current_user.id}_online", "1")
    stream_from("notifications_#{current_user.id}_channel")
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])
    if conversation && conversation.participates?(current_user)
      personal_message = current_user.personal_messages.build({body: data['message']})
      personal_message.conversation = conversation
      personal_message.save!
    end
  end

  private

  def redis
    Redis.new
  end
end