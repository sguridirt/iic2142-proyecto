class MaterialType < ApplicationRecord
    has_many :materials
  
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
  end
  