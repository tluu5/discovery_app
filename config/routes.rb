Rails.application.routes.draw do
  resources :locations do
    resource :favorite, only: [:create, :destroy]

    collection do
      get :filter # Custom route for filtering by activity and amenities
    end
  end

  resources :favorites, only: [:index]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }  

  root 'locations#index'

  # Attributes are only needed as a collection to show available activities/amenities
  resources :attributes, only: [] do
    collection do
      get :available
    end
  end
  
  resources :location_attributes, only: [:create, :destroy]

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :locations, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :users
    end
  end
end

