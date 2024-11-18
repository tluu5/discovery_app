Rails.application.routes.draw do
  resources :favorites
  resources :attributes
  resources :location_attributes
  resources :locations
  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  root "locations#index"
  
end
