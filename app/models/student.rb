class Student < ApplicationRecord
  belongs_to :user
  has_many :course_requests, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :evaluation_answers, dependent: :destroy
  has_many :evaluation_feedbacks, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :wishlisted_courses, through: :wishlist, source: :course

  after_create :create_wishlist

  def enrolled_in_course?(course)
    courses.include?(course)
  end

  def create_wishlist
    Wishlist.find_or_create_by(student: self)
  end
end
