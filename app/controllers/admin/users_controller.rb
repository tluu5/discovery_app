class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
