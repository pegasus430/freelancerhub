class NotificationsController < ApplicationController
  #before_action :authenticate_user!
  def index
    @notifications = Notification.all.where(recipient_id: current_user.id).recent
  end

  def mark_as_read
    @notifications = Notification.all.unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end
end
