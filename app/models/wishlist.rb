class Wishlist < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :student_id, uniqueness: { scope: :course_id, message: "already has this course in their wishlist" }
end
