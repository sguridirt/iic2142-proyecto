class CreateConversationParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true
      t.date :joined_date

      t.timestamps
    end
  end
end
