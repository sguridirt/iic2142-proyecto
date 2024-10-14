class AdminController < ApplicationController
  before_action :authenticate_admin!

  def view_users
    @users = User.all
  end

  def new_user
    @user = User.new
    @user.user_role_id = UserRole.find_by(name: "Student").id
    render :add_user
  end
  

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_view_users_path, notice: 'Usuario creado exitosamente.'
    else
      logger.info "Error al crear el usuario: #{@user.errors.full_messages}"
      render :add_user
    end
  end  
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :user_role_id)
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'No tienes acceso a esta página.' unless current_user&.admin?
  end
end
