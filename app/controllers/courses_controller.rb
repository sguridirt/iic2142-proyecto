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
    # Busca el curso por ID
    course = Course.find(params[:id])
    
    # Obtén el estudiante del usuario actual
    student = current_user.student

    # Verifica si ya existe una solicitud para este curso
    existing_request = CourseRequest.find_by(course: course, student: student)

    if existing_request
      # Si ya existe una solicitud, redirige con un mensaje de alerta
      redirect_to courses_path, alert: "Ya has solicitado unirte a este curso."
    else
      # Crear una nueva solicitud de unión
      status = CourseRequestStatus.find_by(name: "pending") # Busca el estado "pending"
      if status
        # Establecer los parámetros para la solicitud
        description = "Solicitud de unión al curso por #{current_user.name}" # Nombre del usuario en la descripción
        start_date = Date.today # Fecha actual
        end_date = start_date + 1.month # Un mes más tarde

        # Crea la solicitud
        CourseRequest.create(
          student: student,
          course: course,
          course_request_status: status,
          start_date: start_date,
          end_date: end_date,
          description: description
        )

        # Redirige con un mensaje de éxito
        redirect_to courses_path, notice: "Has solicitado unirte al curso: #{course.title}."
      else
        # Manejo de errores si no se encuentra el estado
        redirect_to courses_path, alert: "No se pudo crear la solicitud. Estado de solicitud no encontrado."
      end
    end
  end

  # def show
  #   @course = Course.find(params[:id])
  # end
  def show
    @course = Course.find(params[:id])
    if current_user.teacher?
      render 'show_teacher'
    else
      render 'show_student'
    end
  end
end

