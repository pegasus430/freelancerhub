class SessionsController < ApplicationController
  def new 
  end 

  def create
    user = User.find_by(email: session_params[:email].downcase)
    # user = User.from_omniauth(env["omniauth.auth"])
    respond_to do |format|
      if user && user.authenticate(session_params[:password])
        session[:user_id] = user.id
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:user_id] = user.id
        format.html { redirect_to root_path }
        format.json { render json: { success: true, user: user }, status: :ok }
      else
        format.html {
          flash[:notice] = 'Incorrect user or password'
          render 'new'
        }
        format.json {
          render json: { success: false, error: 'Incorrect user or password' }, status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    session.delete(:user_id)
    cookies.delete(:user_id)
    reset_session
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit!
  end
end
