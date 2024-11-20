Rails.application.routes.draw do
  resources :favorites, only: [:index]

  resources :locations do
    collection do
      get :search
    end
  end

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
