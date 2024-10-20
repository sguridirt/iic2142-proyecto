class EvaluationQuestion < ApplicationRecord
  belongs_to :evaluation
  has_many :evaluation_answers, dependent: :destroy

  validates :content, presence: true
  validates :max_points, numericality: { greater_than_or_equal_to: 0 }
end