class Course < ApplicationRecord
    belongs_to :teacher, foreign_key: 'teacher_id'  # Cambia esto si es necesario
    belongs_to :class_type
end

  
