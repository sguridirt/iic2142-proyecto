class CreateConversationMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :conversation_participants}
      t.string :content
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
