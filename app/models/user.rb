class User < ApplicationRecord
  belongs_to :user_role
  has_many :admins
  has_many :teachers
  has_many :students

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_user_role

  def assign_user_role
    if user_role.name == "Student"
      Student.create(user_id: id)
    elsif user_role.name == "Teacher"
      Teacher.create(user_id: id)
    end
  end
end
