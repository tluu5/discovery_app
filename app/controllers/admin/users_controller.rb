class Admin::UsersController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :ensure_admin

  def index
    @users = User.page(params[:page]).per(10) # Add pagination to improve performance
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete your own account."
    elsif @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: "Failed to delete user. It might be associated with other records."
    end
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
