class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])
    stream_from "conversation_#{conversation.id}"
    Rails.logger.info "📡 Subscribed to conversation_#{conversation.id}"
  end
end
