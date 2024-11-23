class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Allow users to update their profile without providing the current password
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password))
    else
      resource.update(params)
    end
  end
end

