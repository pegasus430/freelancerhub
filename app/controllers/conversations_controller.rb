class ConversationsController < ApplicationController
  before_action :set_conversation
  before_action :check_participating!, except: [:index]
  layout :resolve_layout

  def index
    @conversations = Conversation.where(status: "accept").participating(current_user).order('updated_at DESC')
  end

  def show
    @personal_message = PersonalMessage.new
    @conversations = Conversation.where(status: "accept").participating(current_user).order('updated_at DESC')
    @personal_messages = @conversation.personal_messages.includes(:conversation)
    @converstaion = params[:id]
  end

  private
  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
  end

  def check_participating!
    redirect_to root_path unless @conversation && @conversation.participates?(current_user)
  end

  def resolve_layout
    if current_user
      'dashboard'
    else
      'application'
    end
  end
end