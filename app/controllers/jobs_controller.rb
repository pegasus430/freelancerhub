class JobsController < ApplicationController
  layout :resolve_layout
  
  before_action :authenticate_user!

  def index
    @query = Employer.where("user_id is not null")
                     .where(employer_status: "Not Filled")
                     .where("created_at <= ? AND created_at >= ?", Date.today + 80, Date.today - 80 )
                     .order('created_at DESC').ransack(params[:q])

    @employers = @query.result.includes(:applications).paginate(:page => params[:page], :per_page => 12)
  end

  def new
    @job = Job.new
  end

  def create
    client_id = params[:client_id]
    conversation_id = params[:conversation_id]
    author_id = Conversation.find(conversation_id).author_id
    receiver_id = Conversation.find(conversation_id).receiver_id

    # if client_id == author_id
    #      student_id = receiver_id
    # else
    #   student_id = receiver_id
    # end
    student_id = receiver_id

    job = Employer.find(params[:job_name])
    if job.present?
      job.update(:employer_status => "Filled")
      Job.create(:employer_id => client_id, :student_id => student_id)
      redirect_to manage_path, notice: 'You award the job.'
      UserMailer.welcome_employer_email(User.find(student_id)).deliver_now
    else
      redirect_to manage_path, notice: 'Failed awarding the job.'
    end
  end

  private
  def resolve_layout
    if current_user && current_user.is_employer?
       if action_name =~ /index|new|edit/  
         "dashboard"
        else
        "application" 
       end    
    else
      "application"
    end  
  end
end
