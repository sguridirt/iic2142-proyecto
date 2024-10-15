class EvaluationAnswersController < ApplicationController
    before_action :authenticate_user!
  
    def create
      evaluation = Evaluation.find(params[:evaluation_id])
      course = evaluation.course
  
      params[:answers].each do |question_id, answer_data|
        content = answer_data[:content].presence || "no se respondió"
  
        EvaluationAnswer.create(
          content: content,
          points: 0,
          evaluation_status: 1, 
          evaluation_question_id: answer_data[:evaluation_question_id],
          student_id: answer_data[:student_id]
        )
      end
  
      flash[:notice] = "Respuestas guardadas correctamente."
      redirect_to course_path(course)
    end
  end
  