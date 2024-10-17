class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'ConversationParticipant'
  has_one :user, through: :sender

  validates :content, presence: true
end
