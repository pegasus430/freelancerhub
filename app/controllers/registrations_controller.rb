class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end
  
  def newinvite
    @user = User.new
  end
  
  def employersignup
     @user = User.new
  end
  
  def studentsignup
     @user = User.new 
  end

  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        
        session[:user_id] = @user.id
        cookies.permanent[:user_id] = @user.id

        if @user.is_student
          UserMailer.welcome_student_email(@user).deliver_now
          
          format.html { redirect_to new_user_student_profile_path(@user), notice: 'Successfully registered!' }
          format.json { render :show, status: :created, location: @user }
        else
          UserMailer.welcome_employer_email(@user).deliver_now

          format.html { redirect_to new_user_employer_profile_path(@user), notice: 'Successfully registered!' }
          format.json { render :show, status: :created, location: @user }
        end
      else
        signup_action = (params[:user][:is_student] == "true") ? "studentsignup" : "employersignup"
        format.html { render action: signup_action }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  private
  def sign_up_params
      params.require(:user).permit(:name, :first_name, :last_name, :email, :about, :password, :password_confirmation)
    end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :is_employer, :is_student, :is_admin, :first_name, :last_name, :full_name, :postal_code, :age, :active_at, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :company_name)
  end
end