class TeacherReviewsController < ApplicationController
  def new
    @teacher_review = TeacherReview.new
    @teachers = Teacher.all
    render 'reviews/teacher_review'
  end

  def create
    @teacher_review = TeacherReview.new(teacher_review_params)
    @teacher_review.student_id = current_user.student.id

    if @teacher_review.save
      redirect_to home_path, notice: 'Reseña de profesor creada exitosamente.'
    else
      @teachers = Teacher.all
      render :new
    end
  end

  private

  def teacher_review_params
    params.require(:teacher_review).permit(:teacher_id, :rating, :title, :comment)
  end
  
end
