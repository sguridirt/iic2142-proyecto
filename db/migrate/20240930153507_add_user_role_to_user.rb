class AddUserRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :user_role, foreign_key: true
  end
end
