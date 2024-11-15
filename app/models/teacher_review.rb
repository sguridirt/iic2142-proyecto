class TeacherReview < ApplicationRecord
  belongs_to :student 
  belongs_to :teacher 

  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..5 }
  end
