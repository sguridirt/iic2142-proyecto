class UpdateForeignKeyOnEnrollments < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :enrollments, :courses
    add_foreign_key :enrollments, :courses, on_delete: :cascade
  end
end

