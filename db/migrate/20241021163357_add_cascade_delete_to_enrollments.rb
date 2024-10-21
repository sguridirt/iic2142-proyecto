class AddCascadeDeleteToEnrollments < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :enrollments, :students
    add_foreign_key :enrollments, :students, on_delete: :cascade
  end
end
