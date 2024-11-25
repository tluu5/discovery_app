class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Configure Devise permitted parameters, ensuring sensitive attributes are not exposed
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # Redirect users to their profile page after successful account update
  def after_update_path_for(resource)
    user_path(resource) # Assuming a profile page exists for the user
  end  
end
