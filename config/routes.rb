Rails.application.routes.draw do
  # Root route
  root to: 'locations#index'

  # Devise Routes (Custom Controller for Registrations)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Locations Routes
  resources :locations do
    resource :favorite, only: [:create, :destroy]
  end

  # Favorites index (list of user's favorite locations)
  resources :favorites, only: [:index]

  # Attributes Routes
  resources :attributes, only: [:index, :new, :create, :edit, :update] do
    collection do
      get :available
    end
  end

  # LocationAttributes management
  resources :location_attributes, only: [:create, :destroy]

  # Admin namespace with authentication restriction
  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :locations, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :users
    end
  end

  # API namespace with restricted access
  namespace :api do
    resources :locations, only: [:index]
  end
end
