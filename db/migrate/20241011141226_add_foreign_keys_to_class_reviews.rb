class AddForeignKeysToClassReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :course_reviews, :student, null: false, foreign_key: true
    add_reference :course_reviews, :course, null: false, foreign_key: true
  end
end
