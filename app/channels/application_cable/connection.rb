# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      user_id = request.headers['x-user-id'] || cookies[:user_id]
      current_user = User.find_by(id: user_id) if user_id.present?
      current_user = User.find_by(token: request.params[:token]) if current_user.blank?

      if current_user.blank?
        reject_unauthorized_connection
      else
        current_user
      end
    end
  end
end