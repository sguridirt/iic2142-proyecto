class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :create_message]
  def index
    @conversations = current_user.conversations
    Rails.logger.info @conversations.inspect
  end

  def show
    unless @conversation.users.include?(current_user)
      redirect_to conversations_path, alert: 'No tienes acceso a esta conversación.'
    end

    @messages = @conversation.messages
  end

  def create_message
    @message = @conversation.messages.build(message_params)
    puts @message.inspect
    @message.sender = current_user

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      Rails.logger.info @message.errors.full_messages
      redirect_to conversation_path(@conversation), alert: 'No se ha podido enviar el mensaje.'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def message_params
    puts params.inspect
    params.require(:conversation_message).permit(:content)
  end
end
