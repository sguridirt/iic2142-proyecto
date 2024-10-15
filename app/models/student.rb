class Student < ApplicationRecord
  belongs_to :user
  has_many :course_requests
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :evaluation_answers, dependent: :destroy

  def enrolled_in_course?(course)
    courses.include?(course)
  end
end
