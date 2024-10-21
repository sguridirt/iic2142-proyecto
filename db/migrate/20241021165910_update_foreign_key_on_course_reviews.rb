class UpdateForeignKeyOnCourseReviews < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :course_reviews, :courses
    add_foreign_key :course_reviews, :courses, on_delete: :cascade
  end
end
