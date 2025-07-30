class ChatroomController < ApplicationController
  before_action :require_user
  def index
  @messages = Message.where(conversation_id: nil).order(created_at: :asc)
  @message = Message.new
  end

end

