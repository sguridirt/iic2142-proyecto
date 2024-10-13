class AdminController < ApplicationController
  def view_users
    # Aquí puedes agregar la lógica necesaria, por ejemplo, para listar los usuarios
    @users = User.all # Si tienes un modelo User y deseas mostrar a todos los usuarios
  end
end
