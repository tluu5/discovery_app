class Admin::LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_location, only: [:edit, :update, :destroy]

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
      flash.now[:alert] = @location.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to admin_locations_path, notice: "Location deleted successfully."
    else
      redirect_to admin_locations_path, alert: "Failed to delete location. It might be associated with other records."
    end
  end

  def update
    if @location.update(location_params)
      redirect_to admin_locations_path, notice: "Location updated successfully."
    else
      render :edit, alert: "Failed to update location."
    end
  end

  def show

  end

  private

  def set_location
    @location = Location.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_locations_path, alert: "Location not found."
  end

  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude, :description)
  end

  def ensure_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
