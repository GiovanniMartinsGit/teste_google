Rails.application.routes.draw do
  
  
  devise_for :merchants, controllers: {
    omniauth_callbacks: 'merchants/omniauth_callbacks',
    sessions: 'merchants/sessions',
    registrations: 'merchants/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :merchants
  resources :sales

  # Defines the root path route ("/")
  root to: "sales#index"
end
