class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.student.present?
      @courses = current_user.student.courses
    elsif current_user.teacher.present?
      @courses = current_user.teacher.courses
    else
      @courses = []
    end
  end
end
