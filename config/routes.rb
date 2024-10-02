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

  get 'settings', to: 'user_settings#show', as: 'user_settings'
  get 'settings/edit', to: 'user_settings#edit', as: 'user_settings_edit'
  patch 'settings', to: 'user_settings#update'
end





