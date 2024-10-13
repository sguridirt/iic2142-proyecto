Rails.application.routes.draw do
  root "pages#index"
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations' 
  }

  resources :courses do
    member do
      post 'request_join'  
    end
  end

  resources :requests, only: [:index, :create, :destroy] 
  
  resources :requests do
    member do
      post 'approve', to: 'requests#approve'
      post 'reject', to: 'requests#reject'
    end
  end

  resources :evaluations, only: [:new, :create, :destroy, :show] do
    resources :evaluation_questions, only: [:new, :create]
  end
  
  get '/teacher_requests', to: 'requests#teacher_requests'
  get 'settings', to: 'user_settings#show', as: 'user_settings'
  get 'settings/edit', to: 'user_settings#edit', as: 'user_settings_edit'
  patch 'settings', to: 'user_settings#update'

  get 'home', to: 'home#index'

  resources :courses do
    member do
      get 'upload_material'
      post 'process_upload_material'
    end
  end

  resources :reviews, only: [:view]
  get 'reviews', to: 'reviews#view'

  
  resources :teacher_reviews, only: [:new, :create]
  resources :course_reviews, only: [:new, :create]

  get 'admin/view_users', to: 'admin#view_users'

  
  

end






