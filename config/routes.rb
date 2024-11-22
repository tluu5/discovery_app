Rails.application.routes.draw do
  resources :locations do
    resource :favorite, only: [:create, :destroy]
  end

  resources :favorites, only: [:index] 

  devise_for :users

  root 'locations#index'

  # Additional resources
  resources :attributes do
    collection do
      get :available
    end
  end  
  resources :location_attributes, only: [:create, :destroy]

  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :locations
      resources :users
    end
  end  
end
