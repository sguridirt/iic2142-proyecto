class ChangeIsGroupNotNullInConversations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :conversations, :is_group, false
  end
end