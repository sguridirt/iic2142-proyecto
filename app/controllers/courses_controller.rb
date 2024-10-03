class CoursesController < ApplicationController
  def index
    if params[:query].present?
      @courses = Course.joins(:teacher)
                       .where("courses.title ILIKE ? OR teachers.user_id IN (SELECT id FROM users WHERE name ILIKE ?)", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @courses = Course.all
    end
  end

  def request_join
    course = Course.find(params[:id])
    
    student = current_user.student

    existing_request = CourseRequest.find_by(course: course, student: student)

    if existing_request
      redirect_to courses_path, alert: "Ya has solicitado unirte a este curso."
    else
      status = CourseRequestStatus.find_by(name: "pending")
      if status
        description = "Solicitud de unión al curso por #{current_user.name}" # Nombre del usuario en la descripción
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
    if current_user.teacher?
      render 'show_teacher'
    else
      render 'show_student'
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :course_type_id, :start_date, :end_date)
  end
end

