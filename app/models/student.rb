class Student < ApplicationRecord
  belongs_to :user
  has_many :course_requests, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :evaluation_answers, dependent: :destroy
  has_many :evaluation_feedbacks, dependent: :destroy

  def enrolled_in_course?(course)
    courses.include?(course)
  end
end
