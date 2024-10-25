class EvaluationAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    evaluation = Evaluation.find(params[:evaluation_id])
    course = evaluation.course
    
    if params[:answers].blank?
      flash[:alert] = 'No se proporcionaron respuestas.'
      redirect_to course_path(course) and return
    end

    params[:answers].each do |question_id, answer_data|
      content = answer_data[:content].presence || "no se respondió"

      @evaluation_answer = EvaluationAnswer.create(
        content: content,
        points: 0,
        evaluation_status: 1, 
        evaluation_question_id: answer_data[:evaluation_question_id],
        student_id: answer_data[:student_id]
      )
    end

    if @evaluation_answer.save
      flash[:notice] = "Respuestas guardadas correctamente."
      redirect_to course_path(course)
    else
      Rails.logger.debug @evaluation_answer.errors.full_messages
      flash[:alert] = 'Falla al crear la respuesta'
      render :new
    end
  end
end
  