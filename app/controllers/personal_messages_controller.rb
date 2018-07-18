class PersonalMessagesController < ApplicationController
  before_action :check_receiver!, only: [ :create]
  before_action :authenticate_user!, only: [:new]
  def new
    @receiver = User.find_by(id: params[:receiver])
    redirect_to conversation_path(@conversation) and return if @conversation
    @personal_message = current_user.personal_messages.build
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end

  def create
    @conversation ||= Conversation.create(name: "lksdj", author_id: current_user.id, receiver_id: @receiver.id, status: params[:status])
    #@folder = Folder.create(name: @conversation.id, folder_id: @conversation.id, conversation_id: @conversation.id)
    flash[:success] = "ok!"
    redirect_to conversation_path(@conversation)
  end

  def invite_to_student
    @conversation = Conversation.where(author_id: current_user.id, receiver_id: params[:receiver]).first rescue nil
    @conversation = Conversation.where(author_id: params[:receiver], receiver_id: current_user.id).first rescue nil if @conversation.nil?
    if @conversation.nil?
       @conversation ||= Conversation.create(name: current_user.name, author_id: current_user.id, receiver_id: params[:receiver], status: params[:status])
    end
    if params[:job_name].present?
         job = current_user.employers.find(params[:job_name]) rescue nil
         job_link = "<a href='/employers/#{job.id}'>#{job.title}</a>" if job.present?
         if defined? job_link
           personal_message_params[:body].concat("<br/>").concat(job_link) unless job_link.nil?
         end
       end
     @personal_message = current_user.personal_messages.build(personal_message_params)
     @personal_message.conversation_id = @conversation.id
     if @personal_message.save!
       @conversation.update(folder_id: @conversation.id, status: params[:status])
     end
    flash[:notice] = "Invited"
    redirect_to conversation_path(@conversation)
  end

  private

  def personal_message_params
    params.require(:personal_message).permit(:body)
  end

  def check_receiver!
    @receiver = User.find_by(id: params[:receiver])
    redirect_to(root_path) and return unless @receiver
    @conversation = Conversation.between(current_user.id, @receiver.id)[0]
  end
end