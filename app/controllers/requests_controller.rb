class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_request, only: [:destroy]
  def index
    if current_user.student.present?
      @requests = CourseRequest.where(student_id: current_user.student.id)
    else
      @requests = []
    end
  end

  def destroy
    @course_request.destroy
    redirect_to requests_path, notice: "La solicitud ha sido eliminada exitosamente."
  end

  private

  def set_course_request
    @course_request = CourseRequest.find(params[:id])
  end
end

  