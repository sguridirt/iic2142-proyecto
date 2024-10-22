class AddCascadeDeleteToConversationParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :conversation_participants, :users
    add_foreign_key :conversation_participants, :users, on_delete: :cascade
  end
end

