class Material < ApplicationRecord
  belongs_to :course
  belongs_to :material_type
  has_one_attached :document

  validates :name, presence: { message: "no puede estar en blanco" }
  validates :description, presence: { message: "no puede estar en blanco" }
  validates :material_type_id, presence: { message: "no puede estar en blanco" }
end
