class ConversationsController < ApplicationController
  before_action :require_user

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])

    unless [@conversation.sender_id, @conversation.recipient_id].include?(current_user.id)
      redirect_to conversations_path, alert: "Not authorized"
      return
    end

    @messages = @conversation.messages.order(:created_at)
    @messages.where.not(user_id: current_user.id).update_all(read: true)

    @message = Message.new
    
  end

  def create
    recipient_id = params[:recipient_id]
    @conversation = Conversation.between(current_user.id, recipient_id).first

    if @conversation.nil?
      @conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient_id)
    end

    redirect_to conversation_path(@conversation)
  end
end
