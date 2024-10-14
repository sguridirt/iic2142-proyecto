class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]

  def view_users
    @users = User.all
  end

  def new
    @user = User.new
    @user.user_role_id = UserRole.find_by(name: "Student").id
    render :add_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_view_users_path, notice: 'Usuario creado exitosamente.'
    else
      logger.info "Error al crear el usuario: #{@user.errors.full_messages}"
      render :add_user
    end
  end

  def edit_user
    # This action is needed to render the edit form
  end
  
  def update_user
    if @user.update(user_update_params)
      redirect_to admin_view_users_path, notice: 'Usuario actualizado exitosamente.'
    else
      logger.info "Error al actualizar el usuario: #{@user.errors.full_messages}"
      render :edit_user
    end
  end

  def destroy_user
    @user.destroy
    redirect_to admin_view_users_path, notice: 'Usuario eliminado exitosamente.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :user_role_id)
  end

  def user_update_params
    if params[:user][:password].blank?
      params.require(:user).permit(:name, :email, :phone, :avatar, :user_role_id)
    else
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :avatar, :user_role_id)
    end
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'No tienes acceso a esta página.' unless current_user&.admin?
  end
end