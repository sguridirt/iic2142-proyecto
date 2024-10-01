class UserSettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    render :update
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_settings_path, notice: 'Perfil actualizado exitosamente.'
    else
      render :update, notice: 'No se ha actualizado exitosamente.'
    end
  end

  private

  def user_params
    # Filtrar la contraseña solo si está presente
    if params[:user][:password].blank?
      params.require(:user).permit(:name, :email, :phone, :user_role_id)
    else
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :user_role_id)
    end
  end
end


