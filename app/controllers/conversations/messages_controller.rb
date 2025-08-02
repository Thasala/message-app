class Conversations::MessagesController < ApplicationController
  before_action :require_user
  before_action :set_conversation

  def create
    Rails.logger.info "📨 Received POST to create message"
    Rails.logger.info "➡️ Params: #{params.inspect}"

    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      ActionCable.server.broadcast "conversation_#{@conversation.id}", {
        mod: render_message(@message),
        sender_id: current_user.id
      }
      head :ok
    else
      render plain: "Message failed", status: :unprocessable_entity
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
    unless [@conversation.sender_id, @conversation.recipient_id].include?(current_user.id)
      Rails.logger.warn "❌ User #{current_user.id} not authorized for conversation #{@conversation.id}"
      render plain: "Unauthorized", status: :unauthorized
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def render_message(message)
    ApplicationController.renderer.render(
      partial: 'conversations/message',
      locals: { message: message }
    )
  end
end
