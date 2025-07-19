class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast "chatroom_channel", mod_message: render_message(message)
      head :ok
    else
      render plain: "Message failed", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
