class RequestsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      # Verifica si el usuario tiene un estudiante asociado
      if current_user.student.present?
        @requests = ClassRequest.where(students_id: current_user.student.id)
      else
        @requests = [] # O maneja el caso donde no hay estudiante
      end
    end
  end
  