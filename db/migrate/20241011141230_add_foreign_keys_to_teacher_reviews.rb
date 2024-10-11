class AddForeignKeysToTeacherReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :teacher_reviews, :student, null: false, foreign_key: true
    add_reference :teacher_reviews, :teacher, null: false, foreign_key: true
  end
end
