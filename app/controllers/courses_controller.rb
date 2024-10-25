class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    if params[:query].present?
      @courses = Course.joins(:teacher)
                       .where("courses.title ILIKE ? OR teachers.user_id IN (SELECT id FROM users WHERE name ILIKE ?)",
                              "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @courses = Course.all
    end
  end

  def request_join
    course = Course.find(params[:id])
    student = current_user.student
  
    
    existing_enrollment = Enrollment.find_by(course: course, student: student)
  
    if existing_enrollment
      redirect_to courses_path, alert: "Ya estás inscrito en este curso."
    else
      
      existing_request = CourseRequest.find_by(course: course, student: student)
  
      if existing_request
        redirect_to courses_path, alert: "Ya has solicitado unirte a este curso."
      else
        status = CourseRequestStatus.find_by(name: "pending")
        if status
          description = "Solicitud de unión al curso por #{current_user.name}"
          start_date = Date.today
          end_date = start_date + 1.month
  
          CourseRequest.create(
            student: student,
            course: course,
            course_request_status: status,
            start_date: start_date,
            end_date: end_date,
            description: description
          )
  
          redirect_to courses_path, notice: "Has solicitado unirte al curso: #{course.title}."
        else
          redirect_to courses_path, alert: "No se pudo crear la solicitud. Estado de solicitud no encontrado."
        end
      end
    end
  end

  def new
    @course = Course.new
    @course_types = CourseType.all
  end

  def create
    @course = Course.new(course_params)
    @course.teacher = current_user.teacher
    @course_types = CourseType.all

    if @course.save
      redirect_to home_path, notice: "Curso creado exitosamente."
    else
      Rails.logger.error "Failed to create course: #{@course.errors.full_messages.join(', ')}"
      flash[:alert] = "No se pudo crear el curso."
      render :new
    end
  end
  
  def show
    @course = Course.find(params[:id])
    if current_user&.teacher?
      render 'show_teacher'
    elsif current_user&.admin?
      render 'show_admin'
    else
      render 'show_student'
    end
  end

  
  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Curso eliminado exitosamente.'
  end

  private
  
  def course_params
    params.require(:course).permit(:title, :description, :course_type_id, :start_date, :end_date)
  end

  def set_course
    @course = Course.find(params[:id])
  end

end

