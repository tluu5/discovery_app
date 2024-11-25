Rails.application.routes.draw do
  # Root route
  root 'locations#index'

  # Devise Routes (Custom Controller for Registrations)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Locations Routes
  resources :locations do
    resource :favorite, only: [:create, :destroy]

    # Filter is part of the index action, so no need for a separate route
  end

  # Favorites index (list of user's favorite locations)
  resources :favorites, only: [:index]

  # Attributes are used to show available activities/amenities (collection level route)
  resources :attributes, only: [] do
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
end
