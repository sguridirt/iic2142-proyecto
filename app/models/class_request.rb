class ClassRequest < ApplicationRecord
    belongs_to :student  # Asegúrate de que este nombre coincida con el modelo Student
    belongs_to :course   # Asegúrate de que este nombre coincida con el modelo Course

    # Validaciones
    validates :description, presence: true
end
