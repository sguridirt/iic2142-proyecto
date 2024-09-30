class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.boolean :is_group

      t.timestamps
    end
  end
end
