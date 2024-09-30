class MakeConversationMessageForeignKeyNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :conversation_messages, :sender_id, false
  end
end
