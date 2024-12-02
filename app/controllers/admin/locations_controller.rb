class Admin::LocationsController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :authorize_admin
  before_action :set_location, only: %i[edit update destroy]

  # GET /admin/locations
  def index
    @locations = Location.all
  
    # Filter by activities
    if params[:activities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(features: { name: params[:activities], category: "Activity" })
                             .distinct
    end
  
    # Filter by amenities
    if params[:amenities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(features: { name: params[:amenities], category: "Amenity" })
                             .distinct
    end
  
    # Search by name
    if params[:search].present?
      @locations = @locations.where("name ILIKE ?", "%#{params[:search]}%")
    end
  
    respond_to do |format|
      format.html
      format.json { render json: @locations, status: :ok }
    end
  end  

  # GET /admin/locations/new
  def new
    @location = Location.new
  end

  # POST /admin/locations
  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path, notice: "Location created successfully."
    else
      flash.now[:alert] = @location.errors.full_messages.to_sentence
      render :new
    end
  end

  # PATCH/PUT /admin/locations/:id
  def update
    if @location.update(location_params)
      redirect_to admin_locations_path, notice: "Location updated successfully."
    else
      flash.now[:alert] = @location.errors.full_messages.to_sentence
      render :edit
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

  def set_location
    @location = Location.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_locations_path, alert: "Location not found."
  end

  def location_params
    params.require(:location).permit(
      :name, :address, :latitude, :longitude, :description,
      activities: [], amenities: [], images: []
    )
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
