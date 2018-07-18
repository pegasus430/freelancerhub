class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_notifications, if: :user_signed_in?

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end
  
  
  def authenticate_user!
    redirect_to new_session_path, notice: 'You have to be logged in to do that!' unless current_user
  end
  
  def authenticate_superadmin!
    redirect_to new_session_path, notice: 'Invalid user' unless current_user && current_user.super_admin
  end

  def current_user
    if session[:user_id]
      User.find { |u| u.id == session[:user_id] }
    else
      nil
    end
  end

  #def current_user
  #  user_id = request.headers['x-user-id'] || cookies[:user_id]
  #
  #  @current_user ||= if user_id.present?
  #    User.find_by(id: user_id)
  #  else params[:user_id].present?
  #    User.find_by(id: params[:user_id]) #SHOWING USER_ID IN URL IS NOT SAFE. SHOULD CHANGE THIS TO TOKENS!
  #  end
  #end
  
  def authenticate_admin!
    redirect_to new_session_path, notice: 'Invalid user' unless current_user && current_user.is_admin
  end
  
  def user_signed_in?
    !!current_user
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  
  def sign_out
    session.delete(:user_id)
  end

  rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
  end

  helper_method :current_user_subscribed?
  helper_method :current_user, :user_signed_in?
end