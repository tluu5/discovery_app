class Admin::LocationsController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :authorize_admin
  before_action :set_location, only: %i[edit update destroy]

  # POST /admin/locations
  def create
    @location = Location.new(location_params)

    if @location.save
      assign_features(@location) # Assign activities and amenities
      redirect_to admin_locations_path, notice: "Location created successfully."
    else
      flash.now[:alert] = @location.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/locations/:id
  def update
    if @location.update(location_params)
      assign_features(@location) # Assign activities and amenities
      redirect_to admin_locations_path, notice: "Location updated successfully."
    else
      flash.now[:alert] = @location.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/locations/:id
  def destroy
    if @location.destroy
      redirect_to admin_locations_path, notice: "Location deleted successfully."
    else
      redirect_to admin_locations_path, alert: "Failed to delete location. It may be associated with other records."
    end
  end

  private

  # Fetch the location by ID, or handle RecordNotFound
  def set_location
    @location = Location.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_locations_path, alert: "Location not found."
  end

  # Strong parameters to allow permitted attributes
  def location_params
    params.require(:location).permit(
      :name, :address, :latitude, :longitude, :description,
      images: [], # Accept uploaded images
      activities: [], # Accept an array of activity strings
      amenities: [] # Accept an array of amenity strings
    )
  end

  # Assign activities and amenities to the location
  def assign_features(location)
    # Assign activities
    activity_features = Attribute.where(name: location_params[:activities], category: "Activity")
    location.activities = activity_features.presence || []

    # Assign amenities
    amenity_features = Attribute.where(name: location_params[:amenities], category: "Amenity")
    location.amenities = amenity_features.presence || []
  rescue StandardError => e
    Rails.logger.error "Error assigning features: #{e.message}"
    flash.now[:alert] = "An error occurred while assigning features."
  end

  # Ensure only admins can access these actions
  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
