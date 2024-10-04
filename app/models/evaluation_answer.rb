class EvaluationAnswer < ApplicationRecord
  belongs_to :evaluation_question
  belongs_to :student

  validates :content, presence: true
  validates :points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end