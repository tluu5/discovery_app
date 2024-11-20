Rails.application.routes.draw do
  resources :locations do
    resource :favorite, only: [:create, :destroy]
  end

  resources :favorites, only: [:index] 

  devise_for :users

  root 'locations#index'

  # Additional resources
  resources :attributes, except: [:edit]
  resources :location_attributes, only: [:create, :destroy]

  # Admin-specific routes
  namespace :admin do
    resources :locations
    resources :users
  end
end
