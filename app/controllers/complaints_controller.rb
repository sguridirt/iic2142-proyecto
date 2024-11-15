class ComplaintsController < ApplicationController
  before_action :authenticate_user! # Asegúrate de que el usuario esté autenticado

  def new
    @complaint = Complaint.new
  end

  def create
    @complaint = Complaint.new(complaint_params)
    @complaint.user = current_user # Asocia el reclamo con el usuario actual

    if @complaint.save
      redirect_to home_path, notice: "Reclamo creado con éxito."
    else
      flash.now[:alert] = "Hubo un error al crear el reclamo."
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @complaints = Complaint.includes(:user) # Carga los reclamos con sus autores
  end

  def show
    @complaint = Complaint.find(params[:id])
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "No tienes acceso a esta sección." unless current_user.admin.present?
  end

  def complaint_params
    params.require(:complaint).permit(:title, :content)
  end
end
