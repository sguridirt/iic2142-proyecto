class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher!, only: [:new, :create]

  def new
    @evaluation = Evaluation.new
    @evaluation.evaluation_questions.build
    @teacher_courses = current_user.teacher.courses
    @evaluation.course_id = params[:course_id] if params[:course_id].present?
  end

  def create
    @evaluation = Evaluation.new(filtered_evaluation_params)
    @teacher_courses = current_user.teacher.courses
    if @evaluation.save
      Rails.logger.info "Evaluation created successfully."
      redirect_to course_path(@evaluation.course_id), notice: "Evaluación creada exitosamente."
    else
      Rails.logger.error "Failed to create evaluation: #{@evaluation.errors.full_messages.join(", ")}"
      flash.now[:alert] = "No se pudo crear la evaluación: #{@evaluation.errors.full_messages.join(", ")}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @evaluation = Evaluation.find(params[:id])
  end

  private

  def ensure_teacher!
    unless current_user.teacher?
      redirect_to home_path, alert: "Debes ser profesor para realizar esta acción."
    end
  end

  def evaluation_params
    params.require(:evaluation).permit(:name, :start_date, :duration, :course_id, :evaluation_type_id, 
                                       evaluation_questions_attributes: [:content])
  end

  def filtered_evaluation_params
    params = evaluation_params
    if params[:evaluation_questions_attributes]
      params[:evaluation_questions_attributes].reject! { |_, question| question[:content].blank? }
    end
    params
  end
end