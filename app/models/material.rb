class Material < ApplicationRecord
    belongs_to :course, foreign_key: :course_id
    belongs_to :material_type 
end
