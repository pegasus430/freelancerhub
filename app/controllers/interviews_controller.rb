class InterviewsController < ApplicationController
  layout :resolve_layout
  
  before_action :authenticate_user!
  before_action :set_interview, only: [:show, :edit, :update, :destroy]
  before_action :set_student, only: [:show, :edit, :update, :destroy]
 
  # GET /interviews
  def index
    @employers = Employer.all.where(employer_id: current_user.id).order('created_at DESC')
    #@students = Student.all.where(student_id: current_user.id).order('created_at DESC')
    @interviews =  Interview.where(user_id: current_user.id).order('created_at DESC')
    @student_interviews = Interview.where(student_id: current_user.id).paginate(:page => params[:page], :per_page => 3).order('created_at DESC')
    
    # @employer_user_id = Employer.find(@interviews.user_id)
    interview_ids = Interview.where(user_id: current_user.id ).collect(&:employer_id).uniq rescue []
    @all_interview_jobs = current_user.employers.where(id: interview_ids).order('created_at DESC')
    @interview_jobs = current_user.employers.where(id: interview_ids).order('created_at DESC').paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    @student_applied_jobs =  current_user.is_student? ? current_user.applied_jobs.order('created_at DESC') : []
  end
  
  def student_applications
    interview_ids = Interview.where(user_id: current_user.id ).collect(&:employer_id).uniq rescue []
    @all_interview_jobs = current_user.employers.where(id: interview_ids).order('created_at DESC')
    @interview_jobs = current_user.employers.where(id: interview_ids).order('created_at DESC').paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
  end 
   
  def job_filter
    @employer = Employer.find(params[:select_job]) rescue nil
    if @employer.nil?
      interview_id = Interview.where(user_id: current_user.id).collect(&:employer_id).uniq rescue []
    else
      interview_id = Interview.where(employer_id: @employer.id ).collect(&:employer_id).uniq rescue []
    end
    interview_ids = Interview.where(user_id: current_user.id ).collect(&:employer_id).uniq rescue []
    @all_interview_jobs = current_user.employers.where(id: interview_ids).order('created_at DESC')
    @interview_jobs = current_user.employers.where(id: interview_id).order('created_at DESC').paginate(:page => params[:page], :per_page => 2).order('created_at DESC')
    render "index"
  end

  # GET /interviews/1
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
    @receiver = User.find_by(id: params[:receiver]) 
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews
  def create
    @interview = Interview.new(interview_params)

    @conversation = Conversation.find_by(author_id: current_user.id, receiver_id: @interview.user_id)
    @conversation = Conversation.find_by(author_id: @interview.user_id, receiver_id: current_user.id ) if @conversation.nil?
    if @conversation.nil?
      @conversation = Conversation.create!(name: "Interview", author_id: current_user.id, receiver_id: @interview.user_id, status: params[:status])
    end

    job_link = "<a href='/interviews/job_filter?select_job=#{@interview.employer.id}'>#{@interview.employer.title}</a>"
    
    body = interview_params[:body].concat("<br/>").concat(job_link)

    if @interview.save!
      #@interview.update({:conversation_id => @conversation.id, :student_id => current_user.id})
      @interview.update!({:conversation_id => @conversation.id, :student_id => params[:student_id]})

        #@personal_message = current_user.personal_messages.build({body: body, conversation_id: @conversation.id})
        #@personal_message.conversation_id = @conversation.id
        #if @personal_message.save
        #  @conversation.update(folder_id: @conversation.id, status: params[:status])
        #end

      InterviewMailer.interview_email(@interview).deliver_now

      redirect_to interviews_path, notice: 'Interview was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /interviews/1
  def update
    if @interview.update(interview_params)
      redirect_to @interview, notice: 'Interview was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /interviews/1
  def destroy
    @interview.destroy
    redirect_to interviews_url, notice: 'Interview was successfully destroyed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end
    
     def resolve_layout
      if current_user
        "dashboard" 
      else
        "application"
      end  
    end
   
    # Only allow a trusted parameter "white list" through.
    def interview_params
      params.require(:interview).permit(:body, :title, :video_link, :job_requirement, :name, :email, :user_id, :conversation_id, :student_id, :employer_id, :employer_name, :employer_title)
    end
end