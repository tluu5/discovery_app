class Admin::UsersController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :ensure_admin

  def index
    @users = User.page(params[:page]).per(10) # Add pagination to improve performance
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now # Send the welcome email
      redirect_to admin_users_path, notice: "User created and welcome email sent."
    else
      flash.now[:alert] = "Failed to create user."
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User successfully updated."
    else
      flash.now[:alert] = "Failed to update user. Please check the form for errors."
      render :edit, status: :unprocessable_entity
    end
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

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end  

  def ensure_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
