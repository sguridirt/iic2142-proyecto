class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher!, only: [:new, :create, :destroy]
  before_action :set_evaluation, only: [:show, :show_student, :destroy]


  def show
    @course = @evaluation.course
    @questions = @evaluation.evaluation_questions
    render 'show_teacher'
  end


  def new
    @evaluation = Evaluation.new
    @evaluation.evaluation_questions.build
    @teacher_courses = current_user.teacher.courses
    @evaluation.course_id = params[:course_id] if params[:course_id].present?
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.save
      redirect_to course_path(@evaluation.course), notice: "Evaluación creada exitosamente."
    else
      @teacher_courses = current_user.teacher.courses
      flash.now[:alert] = "No se pudo crear la evaluación."
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @evaluation.destroy
    redirect_to course_path(@evaluation.course), notice: "Evaluación eliminada."
  end

  private

  def show_student
    @course = @evaluation.course
    @questions = @evaluation.evaluation_questions
  
    if current_user.student.evaluation_answers.joins(:evaluation_question)
                   .where(evaluation_questions: { evaluation_id: @evaluation.id })
                   .exists?(evaluation_status: 1)
      redirect_to course_path(@course), alert: "Ya has realizado esta evaluación."
    else
      render 'show_student'
    end
  end

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:name, :start_date, :duration, :course_id, :evaluation_type_id, 
                                       evaluation_questions_attributes: [:id, :content, :max_points, :_destroy])
  end


  def ensure_teacher!
    unless current_user.teacher?
      redirect_to root_path, alert: "Debes ser profesor para realizar esta acción."
    end
  end
end
