class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :course_type
end

  
