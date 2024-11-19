class Admin::LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path, notice: "Location created successfully."
    else
      render :new, alert: "Failed to create location."
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to admin_locations_path, notice: "Location deleted successfully."
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude, :description)
  end

  def ensure_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
