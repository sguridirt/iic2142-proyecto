class AddUserOnDeleteCascadeToTeacher < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :teachers, :users
    add_foreign_key :teachers, :users, null: false
  end
end
