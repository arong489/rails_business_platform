Rails.application.routes.draw do

  get 'favorites_items', to: 'favorites_items#index', as: :favorites_items
  post 'favorites_items/:product_id', to: 'favorites_items#create', as: :new_favorites
  delete 'favorites_items/:product_id', to: 'favorites_items#destroy', as: :delete_favorites

  resources :cart_items
  devise_for :users
  resources :products
  resources :types
  resources :sizes
  resources :colors
  resources :designs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
