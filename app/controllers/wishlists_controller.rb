class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_student
  before_action :set_wishlist

  def show
    @wishlist_courses = @wishlist.courses
  end

  def create
    course = Course.find(params[:course_id])

    if current_user.student.courses.exists?(course.id)
      redirect_to courses_path, alert: 'Ya estás inscrito en este curso'

    elsif @wishlist.courses.exists?(course.id)
      redirect_to courses_path, alert: 'El curso ya está en tu wishlist'
    else
      @wishlist.courses << course
      redirect_to courses_path, notice: 'Curso añadido a tu wishlist'
    end
  end

  def destroy
    course = Course.find(params[:course_id])
    @wishlist.courses.delete(course)
    redirect_to wishlist_path, notice: 'Curso eliminado de tu wishlist'
  end

  private

  def ensure_student
    unless current_user.student?
      redirect_to home_path, alert: 'Solo los estudiantes pueden agregar cursos a su wishlist.'
    end
  end

  def set_wishlist
    @wishlist = current_user.student.wishlist || current_user.student.create_wishlist
  end
end