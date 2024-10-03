class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :course_type
  has_many :enrollments
  has_many :students, through: :enrollments

  has_many :materials, foreign_key: :course_id
  has_many :evaluations, foreign_key: :course_id, dependent: :destroy 
end

