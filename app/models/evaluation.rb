class Evaluation < ApplicationRecord
  belongs_to :course
  belongs_to :evaluation_type
  has_many :evaluation_questions, dependent: :destroy
  accepts_nested_attributes_for :evaluation_questions, allow_destroy: true

  validates :name, presence: true
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
end