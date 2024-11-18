Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy]
  resources :attributes
  resources :location_attributes
  resources :locations
  devise_for :users

  root "locations#index" # Set the homepage
  
  def admin?
    self.admin
  end
end
