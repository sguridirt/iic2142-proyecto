class EvaluationQuestion < ApplicationRecord
  belongs_to :evaluation
  has_many :evaluation_answers, dependent: :destroy

  validates :content, presence: true
end