Rails.application.routes.draw do
  get 'welcome/index'
  # Define your root route ("/")
  # root "home#index"  # Si tienes un controlador llamado HomeController y una acción index
  root "welcome#index"  # Asegúrate de tener un controlador llamado WelcomeController con una acción index
end
