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
      render :update, formats: :html, status: :unprocessable_entity
    end
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:name, :email, :phone, :avatar, :user_role_id)
    else
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :avatar, :user_role_id)
    end
  end
end
