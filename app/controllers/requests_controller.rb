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

  def teacher_requests
    if current_user.teacher.present?
      @requests = CourseRequest.joins(:course)
                               .where(courses: { teacher_id: current_user.teacher.id })
                               .where(course_request_status_id: CourseRequestStatus.find_by(name: "pending").id)
    else
      @requests = [] 
    end
  end


  
  def approve
    request = CourseRequest.find(params[:id])
  

    if request.update(course_request_status: CourseRequestStatus.find_by(name: "accepted"))
      
      Enrollment.create(
        student_id: request.student_id,  
        course_id: request.course_id,    
        enrollment_date: Date.today      
      )
      redirect_to teacher_requests_path, notice: "Solicitud aprobada y estudiante inscrito en el curso."
    else
      redirect_to teacher_requests_path, alert: "Error al aprobar la solicitud."
    end
  end

  def reject
    request = CourseRequest.find(params[:id])
    request.update(course_request_status: CourseRequestStatus.find_by(name: "rejected"))
    redirect_to teacher_requests_path, notice: "Solicitud rechazada."
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

  