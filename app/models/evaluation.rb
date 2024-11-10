class Evaluation < ApplicationRecord
  belongs_to :course
  belongs_to :evaluation_type
  has_many :evaluation_questions, dependent: :destroy
  accepts_nested_attributes_for :evaluation_questions, allow_destroy: true
  
  has_many :evaluation_answers, through: :evaluation_questions
  has_many :students, -> { distinct }, through: :evaluation_answers
  has_many :evaluation_feedbacks, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }

  def graded?(student)
    evaluation_answers.where(student: student).all? { |answer| answer.evaluation_status == 2 }
  end
end