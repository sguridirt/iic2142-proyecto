class Teacher < ApplicationRecord
  belongs_to :user
  has_many :courses
  has_many :reviews, as: :reviewable
end

