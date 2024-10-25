class CourseReviewsController < ApplicationController
  def new
    @course_review = CourseReview.new
    @courses = current_user.student.courses
    render 'reviews/course_review'
  end

  def create
    @course_review = CourseReview.new(course_review_params)
    @course_review.student_id = current_user.student.id

    if @course_review.save
      redirect_to home_path, notice: 'Reseña de curso creada exitosamente.'
    else
      @courses = current_user.student.courses
      render :new
    end
  end

  private

  def course_review_params
    params.require(:course_review).permit(:course_id, :rating, :title, :comment)
  end
  
end
