class RequestsController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.student.present?
      @requests = CourseRequest.where(student_id: current_user.student.id)
    else
      @requests = [] # Maneja el caso donde no hay estudiante
    end
  end
end

  