class User < ApplicationRecord
  belongs_to :user_role
  has_many :admins
  has_many :teachers
  has_many :students
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_user_role

  validates :email,
            format: { with: Devise.email_regexp },
            presence: true,
            uniqueness: { case_insensitive: true }
  validates :phone,
            format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ },
            presence: true,
            uniqueness: { case_insensitive: true }

  def assign_user_role
    if user_role.name == "Student"
      Student.create(user_id: id)
    elsif user_role.name == "Teacher"
      Teacher.create(user_id: id)
    end
  end
  def avatar_thumbnail
    return self.avatar.variant(resize_to_fill: [300, 300], processor: :mini_magick).processed if avatar.attached?
  end

end
