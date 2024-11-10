class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher_or_admin!, only: [:new, :create, :destroy, :grade_answers]
  before_action :set_evaluation, only: [:show, :destroy, :grade_answers, :update_grades]


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

  def show
    @course = @evaluation.course
    @questions = @evaluation.evaluation_questions
  
    if current_user.teacher? || current_user.admin?
      render :show_teacher 
    else
      if current_user.student.evaluation_answers.joins(:evaluation_question)
                     .where(evaluation_questions: { evaluation_id: @evaluation.id })
                     .exists?(evaluation_status: [1, 2])
        redirect_to course_path(@course), alert: "Ya has realizado esta evaluación."
      end
      render :show_student
    end
  end

  def destroy
    @evaluation.destroy
    redirect_to course_path(@evaluation.course), notice: "Evaluación eliminada."
  end

  def grade_answers
    @students = @evaluation.students
    @graded_students = @students.select { |student| @evaluation.graded?(student) }
    @ungraded_students = @students.reject { |student| @evaluation.graded?(student) }

    @current_student = Student.find(params[:student_id])

    @answers = @evaluation.evaluation_answers.where(student_id: @current_student.id)
    @total_points = @answers.sum(:points)
    @max_points = @evaluation.evaluation_questions.sum(:max_points)
  end

  def update_grades
    params[:answers].each do |answer_id, answer_data|
      answer = EvaluationAnswer.find(answer_id)
      answer.update(points: answer_data[:points], evaluation_status: 2)
    end

    redirect_to grade_answers_evaluation_path(@evaluation, student_id: params[:student_id]), 
                notice: "Puntos asignados."
  end

  private

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:name, :start_date, :duration, :course_id, :evaluation_type_id, 
                                       evaluation_questions_attributes: [:id, :content, :max_points, :_destroy])
  end

  def ensure_teacher_or_admin!
    unless current_user.teacher? || current_user.admin?
      redirect_to root_path, alert: "Debes ser profesor para realizar esta acción."
    end
  end
end