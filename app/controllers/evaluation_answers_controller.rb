class EvaluationAnswersController < ApplicationController
    before_action :authenticate_user!
  
    def create
      evaluation = Evaluation.find(params[:evaluation_id]) # Obtener la evaluación
      course = evaluation.course # Obtener el curso asociado a la evaluación
  
      params[:answers].each do |question_id, answer_data|
        content = answer_data[:content].presence || "no se respondió" # Si la respuesta está vacía, se reemplaza por el mensaje
  
        EvaluationAnswer.create(
          content: content,
          points: 0,  # Inicialmente 0 puntos
          evaluation_status: 0,  # Estado inicial
          evaluation_question_id: answer_data[:evaluation_question_id],
          student_id: answer_data[:student_id]
        )
      end
  
      flash[:notice] = "Respuestas guardadas correctamente."
      # Redirigir a la página del curso
      redirect_to course_path(course)
    end
  end
  