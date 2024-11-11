class EvaluationFeedback < ApplicationRecord
  belongs_to :evaluation
  belongs_to :student
  belongs_to :teacher

  validates :content, presence: true
end
