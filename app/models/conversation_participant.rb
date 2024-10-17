class ConversationParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  has_many :conversation_messages, foreign_key: 'sender_id'

  before_create :set_joined_date

  private

  def set_joined_date
    self.joined_date = Date.today
  end
end
