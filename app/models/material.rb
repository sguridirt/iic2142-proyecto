class Material < ApplicationRecord
    belongs_to :course, foreign_key: :course_id
    belongs_to :material_type 

    validates :name, presence: true
    validates :description, presence: true
    validates :material_type, presence: true
    validates :course_id, presence: true 
end
