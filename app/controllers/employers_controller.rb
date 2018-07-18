require 'date'
  
class EmployersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: [:apply_job, :contract]

  before_action :set_employer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :update, :new]
  layout :resolve_layout
  
  has_scope :by_category
  has_scope :by_diploma
  has_scope :by_language
  has_scope :by_state
  has_scope :by_pay
  has_scope :by_work_schedule
  has_scope :by_state
  has_scope :by_city
  has_scope :by_title
  
  def index
    #@employers = apply_scopes(Employer).where("user_id is not null").where(employer_status: "Not Filled").paginate(:page => params[:page], :per_page => 15).order('created_at DESC').recent
    @query = Employer.where("user_id is not null")
                 .where(employer_status: "Not Filled")
                 .where("created_at <= ? AND created_at >= ?", Date.today + 80, Date.today - 80 )
                 .order('created_at DESC').ransack(params[:q])

    @employers = @query.result.includes(:applications).paginate(:page => params[:page], :per_page => 12)
  end

  def show
    @user = @employer.user_id
    set_profile
  end

  def new
    redirect_to "/employer_wizards/step1"

    @employer = Employer.new
    @employer.company_job_logos.build
  end

  def edit
    redirect_to "/employer_wizards/step4?id=#{@employer.id}"

    @employer.company_job_logos.build if @employer.company_job_logos.empty?
  end

  def create
    d = employer_params[:start_date].split("/")
    dt = "#{d[1]}/#{d[0]}/#{d[2]}"
    date = DateTime.parse(dt) rescue nil

    @employer = Employer.new(employer_params)
    @employer.start_date = date

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      d = employer_params[:start_date].split("/")
      dt = "#{d[1]}/#{d[0]}/#{d[2]}"
      date = DateTime.parse(dt) rescue nil
     
      if @employer.update(employer_params)
        @employer.update(start_date: date)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to manage_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def apply_job
    @employer = Employer.find(params[:employer_id])
    @user =  User.find(params[:user_id]) rescue nil
    if @user.student_profile.nil?
      redirect_to new_user_student_profile_path(@user.id)
    end
    
    @interview  = @user.interviews.build(employer_id: @employer.id)
  end 
  
   def send_application
    @employer = Employer.find(params[:id])
    @user = User.find(params[:user_id])
    @interview =  @user.interviews.build(employer_id: @employer.id)
    
    InterviewMailer.interview_email(@interview).deliver_now
   end

  def contract
    conversation_id = params[:conversation_id]
    author_id = Conversation.find(conversation_id).author_id
    receiver_id = Conversation.find(conversation_id).receiver_id

    if params[:client_id].to_i == author_id
      student_id = receiver_id
    else
      student_id = author_id
    end

    job = Employer.find(params[:job_name])
    if job.present?
      job.update_attributes(:employer_status => 'Filled', :awarded_student_id => student_id)

      UserMailer.congrats_email(User.find(student_id)).deliver_now

      Notification.create(recipient: User.find(student_id),
                          sender: User.find(params[:client_id]),
                          action: "posted", notifiable_type: "Contract",
                          notifiable_id: params[:conversation_id])

      redirect_to manage_path, notice: 'You award the job.'
    else
      redirect_to manage_path, notice: 'Failed awarding the job.'
    end
  end

  private
    def set_employer
      @employer = Employer.find(params[:id])
    end
    
    def set_profile
       if current_user && current_user.is_employer?
         if current_user.employer_profile.blank?
             flash[:notice] = "Company profile can't be blank"

             redirect_to "/manage" and return
          end  
      end   
    end
    
    def resolve_layout
      if current_user && current_user.is_employer?
         if action_name =~ /new|edit/  
           'dashboard'
          else
          'application'
         end    
      else
        'application'
      end  
    end

    def employer_params
      params.require(:employer).permit(:title, :name, :user_id, :link, :description, :category,
                                       :responsibility, :requirement, :work_schedule, :diploma,
                                       :written_languages, :spoken_languages, :level_of_study,
                                       :zip_code, :start_date, :url, :image_url, :city, :state,
                                       :pay, :long_description, :years_of_experience, :instagram,
                                       :facebook, :company_website, :linkedin, :additional_link,
                                       :avatar, :status, :employer_status, :job_duration,
                                       :company_job_logos_attributes => [:id, :type, :assetable_id, :asstable_type, :attachment, :_destroy])
    end
end