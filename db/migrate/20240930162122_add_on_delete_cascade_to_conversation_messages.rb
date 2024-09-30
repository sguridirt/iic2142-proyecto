class AddOnDeleteCascadeToConversationMessages < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :conversation_messages, :conversation_participants

    add_foreign_key :conversation_messages, :conversation_participants, column: :sender_id, on_delete: :cascade
  end
end
