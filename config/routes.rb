Rails.application.routes.draw do
  devise_for :users

  # Root route
  root "locations#index"

  # Nested routes for favorites
  resources :locations do
    resources :favorites, only: [:create, :destroy]
  end

  # Additional resources
  resources :attributes, except: [:edit]
  resources :location_attributes, only: [:create, :destroy]

  # Admin-specific routes
  namespace :admin do
    resources :locations
    resources :users
  end
end
