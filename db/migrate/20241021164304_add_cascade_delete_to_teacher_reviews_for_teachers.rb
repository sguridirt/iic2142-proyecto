class AddCascadeDeleteToTeacherReviewsForTeachers < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :teacher_reviews, :teachers
    add_foreign_key :teacher_reviews, :teachers, on_delete: :cascade
  end
end

