class ReviewsController < ApplicationController
  # def view
  #   @teacher = current_user.teacher
  #   @teacher_reviews = @teacher.present? ? @teacher.teacher_reviews : []
  #   @course_reviews = @teacher.present? ? CourseReview.where(course_id: @teacher.courses.pluck(:id)) : []
  # end
  def view 
    @teacher_reviews = TeacherReview.all # Fetch all teacher reviews
    @course_reviews = CourseReview.all  # Fetch all course reviews
  end
end

