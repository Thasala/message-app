class ConversationsController < ApplicationController
  before_action :require_user

  def index
    # Eager load to prevent N+1 and avoid duplicates
    raw_conversations = Conversation
                          .where("sender_id = :id OR recipient_id = :id", id: current_user.id)
                          .includes(:sender, :recipient)

    # Remove duplicate entries by grouping unique pairs
    @conversations = raw_conversations.uniq { |c| [c.sender_id, c.recipient_id].sort }
  end

  def show
    @conversation = Conversation.find(params[:id])

    unless [@conversation.sender_id, @conversation.recipient_id].include?(current_user.id)
      redirect_to conversations_path, alert: "Not authorized"
      return
    end

    # ✅ Mark received messages as read
    @messages = @conversation.messages.order(:created_at)
    @messages.where.not(user_id: current_user.id).update_all(read: true)

    @message = Message.new
  end

  def create
    recipient_id = params[:recipient_id]

    # Ensure recipient exists
    if User.exists?(recipient_id)
      @conversation = Conversation.between(current_user.id, recipient_id).first_or_create do |c|
        c.sender_id = current_user.id
        c.recipient_id = recipient_id
      end

      redirect_to conversation_path(@conversation)
    else
      redirect_to conversations_path, alert: "Invalid recipient"
    end
  end
end
