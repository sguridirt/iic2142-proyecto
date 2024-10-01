class RemoveCoursePluralFormForeignKeyInEnrollment < ActiveRecord::Migration[7.0]
  def change
    rename_column :enrollments, :courses_id, :course_id
  end
end
