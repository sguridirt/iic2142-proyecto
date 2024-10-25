class User < ApplicationRecord
  belongs_to :user_role
  has_one :student
  has_one :teacher
  has_one :admin

  has_many :conversation_participants
  has_many :conversations, through: :conversation_participants
  has_many :messages, class_name: 'ConversationMessage', foreign_key: 'sender_id'
  
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_user_role

  validates :name, presence: true
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
  
  # def avatar_thumbnail
  #   return self.avatar.variant(resize_to_fill: [300, 300], processor: :mini_magick).processed if avatar.attached?
  # end
  def avatar_thumbnail
    return self.avatar.variant(resize_to_fill: [300, 300]).processed if avatar.attached?
  end
  

  def teacher?
    user_role.name == "Teacher"
  end
  
  def student?
    user_role.name == "Student"
  end

  def admin?
    user_role.name == 'Admin' # Suponiendo que el nombre del rol de administrador es 'Admin'
  end

end
