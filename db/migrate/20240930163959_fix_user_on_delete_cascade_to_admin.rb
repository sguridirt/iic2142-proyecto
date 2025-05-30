class FixUserOnDeleteCascadeToAdmin < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :admins, :users
    add_foreign_key :admins, :users, null: false, on_delete: :cascade
  end
end
