class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :course_type
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :materials, foreign_key: :course_id
  has_many :evaluations, foreign_key: :course_id, dependent: :destroy
  has_many :course_requests, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "End date must be after the start date")
    end
  end
end
