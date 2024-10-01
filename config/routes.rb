Rails.application.routes.draw do
  root "pages#index"
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'settings', to: 'user_settings#show', as: 'user_settings'
  get 'settings/edit', to: 'user_settings#edit', as: 'user_settings_edit'
  patch 'settings', to: 'user_settings#update'
end
