class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :create_message, :destroy]
  
  def index
    @conversations = current_user.conversations
    Rails.logger.info @conversations.inspect
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new
    @conversation.is_group = conversation_params[:user_ids].count > 1

    if @conversation.save
      params[:conversation][:user_ids].each do |user_id|
        ConversationParticipant.create(user_id: user_id, conversation: @conversation)
      end
      participant = ConversationParticipant.create(user_id: current_user.id, conversation: @conversation)
      Rails.logger.info "Created participant: #{participant.inspect}"

      redirect_to conversation_path(@conversation)
    else
      Rails.logger.info @conversation.errors.full_messages
      redirect_to conversations_path, alert: 'No se ha podido crear la conversación.'
    end
  end

  def show
    unless @conversation.users.include?(current_user)
      redirect_to conversations_path, alert: 'No tienes acceso a esta conversación.'
    end

    @messages = @conversation.messages
  end

  def create_message
    @message = @conversation.messages.build(message_params)
    participant = @conversation.conversation_participants.find_by(user_id: current_user.id)
    
    if participant
      @message.sender = participant
      puts @message.inspect

      if @message.save
        redirect_to conversation_path(@conversation)
      else
        Rails.logger.info @message.errors.full_messages
        redirect_to conversation_path(@conversation), alert: 'No se ha podido enviar el mensaje.'
      end
    else
      redirect_to conversation_path(@conversation), alert: 'No se ha podido enviar el mensaje. El usuario no es un participante de esta conversación.'
    end
  end

  def destroy
    if @conversation.users.include?(current_user)
      @conversation.destroy
      redirect_to conversations_path, notice: 'Conversación eliminada.'
    else
      redirect_to conversations_path, alert: 'No tienes acceso a esta conversación.'
    end
  end


  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
    
    rescue ActiveRecord::RecordNotFound
    redirect_to conversations_path, alert: 'La conversación no existe o ha sido eliminada.'
  end

  def conversation_params
    params.require(:conversation).permit(user_ids: [])
  end

  def message_params
    puts params.inspect
    params.require(:conversation_message).permit(:content)
  end
end
