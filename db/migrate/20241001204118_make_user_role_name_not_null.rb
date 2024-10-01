class MakeUserRoleNameNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :user_roles, :name, false
  end
end
