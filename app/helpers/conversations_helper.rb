module ConversationsHelper
  def message_sent_by_current_user?(message)
    message.sender.user == current_user
  end
end
