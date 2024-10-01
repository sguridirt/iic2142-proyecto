Rails.application.routes.draw do
  root "pages#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :courses do
    member do
      post 'request_join'  # Esta ruta permite enviar una solicitud para unirse a un curso
    end
  end

  # Añade recursos para las solicitudes
  resources :requests, only: [:index, :create, :destroy] # Puedes añadir otras acciones según sea necesario
end





