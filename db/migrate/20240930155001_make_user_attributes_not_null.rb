class MakeUserAttributesNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :phone, false
    change_column_null :users, :email, false
  end
end
