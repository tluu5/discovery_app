class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Allow users to update their profile without providing the current password
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      # Update without password if no new password is provided
      resource.update_without_password(params.except(:current_password))
    else
      # Update with password validation if the user provided a new password
      resource.update_with_password(params)
    end
  end
end
