class Student < ApplicationRecord
  belongs_to :user
  has_many :course_requests
  has_many :enrollments
  has_many :courses, through: :enrollments
end
