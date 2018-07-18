class UsersController < ApplicationController
  # before_action :require_same_user, only: [:edit, :update ]
  layout :resolve_layout
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    redirect_to root_path and return
    @user = User.find(params[:id])
    @employers = Employer.all.where(user_id: params[:id])
    @students = Student.all.where(user_id: params[:id])
    @educations = Education.all.where(user_id: params[:id])
    @works = Work.all.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def update
    @user = User.find(params[:id])
    #if @user.update_attributes(user_params)
    #  # Handle a successful update.
    #else
    #  render 'edit'
    #end
    respond_to do |format|
      if @user.update(user_params)
        @user.update({:reset_password_token => nil})
        format.html { redirect_to manage_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
         error = @user.errors[:password].join("") rescue "error"
         flash[:error] = error
         format.html { redirect_to :back }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete 
  end
  
  def forgotpassword
    @user = User.find_by(reset_password_token: params[:password_token])
  end
  
  def employersignup
    @user = User.new
  end
  
  def updateaccount
    @user = User.find_by(token: params[:user_token])
    @educations = Education.all.where(user_id: @user.id)
    @works = Work.all.where(user_id: @user.id)
    @education = Education.new
    @work = Work.new
  end
  
  def updateuserinfo
    @user = User.find_by(token: params[:user_token])
    if @user.is_employer?
      render 'update_employer_info'
    end  
  end
  
  def manage
    @user = User.find(current_user.id)
    @employer_current_jobs  =  current_user.employers.order('created_at DESC')
                                                     .where(employer_status: "Not Filled")
                                                     # .where("created_at <= ? AND created_at >= ?", Date.today + 40, Date.today - 40)
    @employer_previous_jobs =  current_user.employers.where(employer_status: "Filled")
                                                     .order('created_at DESC')
                                                     #.where("created_at < ?", 40.days.ago )
    @students =   current_user.students.order('created_at DESC')
    @interviews = current_user.interviews.order('created_at DESC')
  end
  
  private
  def set_profile
    if current_user
      if current_user.is_employer?
        if current_user.employer_profile.blank?
          redirect_to user_employer_profiles_path(current_user) and return
        end    
      end
      if current_user.is_student?
        if current_user.employer_profile.blank?
          redirect_to user_student_profiles_path(current_user) and return
        end  
      end 
    end   
  end
  
  private
  def resolve_layout
    if current_user
       if action_name =~ /manage|updateuserinfo/  
         "dashboard" 
        else
        "application" 
       end    
    else
      "application"
    end  
  end
   
  def user_params
  params.require(:user).permit(:first_name, :last_name, :is_employer, :is_student, :postal_code, :age, :token, :location, :website, :phone, :education, :full_name, :active_at, :last_sign_in_ip, :last_sign_in_at, :sign_in_count, :facebook, :twitter, :instagram, :linkedin, :description, :name, :avatar, :avatar_file_name, :avatar_content_type,:avatar_file_size, :company_name, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "you can only edit your own account"
      redirect_to root_path
    end
  end
end