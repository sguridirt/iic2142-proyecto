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

  resources :evaluations, only: [:new, :create, :show, :destroy] do
    resources :evaluation_questions, only: [:new, :create]
    resources :evaluation_answers, only: [:create]
    member do
      get 'grade_answers/:student_id', to: 'evaluations#grade_answers', as: 'grade_answers'
      patch 'update_grades/:student_id', to: 'evaluations#update_grades', as: 'update_grades'
    end
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
  resources :materials, only: [:destroy, :show]

  get 'admin/view_users', to: 'admin#view_users', as: 'admin_view_users'
  get 'admin/users/new', to: 'admin#new_user', as: 'admin_new_user'
  post 'admin/users', to: 'admin#create_user', as: 'admin_users'
  get 'admin/users/:id/edit', to: 'admin#edit_user', as: 'admin_edit_user'
  patch 'admin/users/:id', to: 'admin#update_user', as: 'admin_user'
  delete 'admin/users/:id', to: 'admin#destroy_user', as: 'admin_destroy_user'
  get 'admin/teacher_reviews', to: 'admin#teacher_reviews', as: 'admin_teacher_reviews'
  delete 'admin/teacher_reviews/:id', to: 'admin#destroy_teacher_review', as: 'admin_destroy_teacher_review'
  get 'admin/course_reviews', to: 'admin#course_reviews', as: 'admin_course_reviews'
  delete 'admin/course_reviews/:id', to: 'admin#destroy_course_review', as: 'admin_destroy_course_review'

  resources :conversations, only: [:index, :show, :new, :create, :destroy] do
    member do
      post 'create_message', to: 'conversations#create_message'
    end
  end
  
end






