class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :student

  validates :rating, presence: true, inclusion: { in: 0..10 }
  validates :content, presence: true
end