class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @courses = Course.all
    @teachers = Teacher.all
  end

  def create
    @review = Review.new(review_params)
    @review.student = current_user.student

    if @review.save
      redirect_to home_path, notice: 'Reseña creada exitosamente.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:reviewable_type, :reviewable_id, :rating, :content)
  end
end
