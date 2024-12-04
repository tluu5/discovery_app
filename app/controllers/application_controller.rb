class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Centralized Error Handling
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :routing_error

  protected

  # Configure Devise permitted parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # Redirect users to their profile page after successful account update
  def after_update_path_for(resource)
    user_path(resource) # Assuming a profile page exists for the user
  end  

  # Custom authentication method
  def custom_authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "You must sign in to perform this action."
    end
  end  

  # Exception Handlers
  private

  def record_not_found(exception)
    Rails.logger.error "Record not found: #{exception.message}"
    redirect_to root_path, alert: "The record you are looking for could not be found."
  end

  def routing_error(exception)
    Rails.logger.error "Routing error: #{exception.message}"
    redirect_to root_path, alert: "The page you requested does not exist."
  end
end
