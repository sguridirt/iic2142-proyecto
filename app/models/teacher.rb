class Teacher < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  has_many :teacher_reviews, dependent: :destroy
  has_many :evaluation_feedbacks, dependent: :destroy


  def user_name
    user.name
  end

  
end


