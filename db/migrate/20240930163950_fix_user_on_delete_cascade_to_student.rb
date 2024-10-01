class FixUserOnDeleteCascadeToStudent < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :students, :users
    add_foreign_key :students, :users, null: false, on_delete: :cascade
  end
end
