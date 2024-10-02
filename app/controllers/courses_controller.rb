class CoursesController < ApplicationController
  def index
    if params[:query].present?
      @courses = Course.joins(:teacher)
                       .where("courses.title ILIKE ? OR teachers.user_id IN (SELECT id FROM users WHERE name ILIKE ?)", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @courses = Course.all
    end
  end
end

  