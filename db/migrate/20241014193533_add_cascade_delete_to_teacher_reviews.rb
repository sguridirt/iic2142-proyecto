class AddCascadeDeleteToTeacherReviews < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :teacher_reviews, :students
    add_foreign_key :teacher_reviews, :students, on_delete: :cascade
  end
end
