class EvaluationType < ApplicationRecord
  has_many :evaluations, dependent: :restrict_with_exception
  validates :name, presence: true
  validates :description, presence: true
  end