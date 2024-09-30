class MakeUserRoleRefNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :user_role_id, false
  end
end
