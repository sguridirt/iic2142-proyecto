class Conversation < ApplicationRecord
  has_many :messages, class_name: 'ConversationMessage', :dependent => :destroy 
  has_many :conversation_participants
  has_many :users, through: :conversation_participants
end