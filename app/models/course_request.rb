class CourseRequest < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :course_request_status
  # Validaciones
  validates :description, presence: true
  end
  
