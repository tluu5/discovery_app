class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Allow users to update their profile without providing the current password
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      # Update without password if no new password is provided
      unless resource.update_without_password(params.except(:current_password))
        flash[:error] = "Failed to update your profile. Please check your inputs."
        return false
      end
    else
      # Update with password validation if the user provided a new password
      unless resource.update_with_password(params)
        flash[:error] = "Password update failed. Ensure your current password is correct."
        return false
      end
    end
    true
  end  
end
