class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations
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

  # GET /locations/:id
  def show
    @map_data = { lat: @location.latitude, lng: @location.longitude }
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/:id/edit
  def edit; end

  # POST /locations
  def create
    @location = Location.new(location_params)
  
    if @location.save
      assign_attributes_to_location # Assign activities and amenities only if save succeeds
      redirect_to location_url(@location), notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity # Consistent error handling
    end
  end

  # PATCH/PUT /locations/:id
  def update
    if @location.update(location_params)
      assign_attributes_to_location

      # Remove selected images
      params[:location][:remove_images]&.each do |image_id|
        image = @location.images.find_by(id: image_id)
        image&.purge
      end

      redirect_to location_url(@location), notice: "Location was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /locations/:id
  def destroy
    @location.destroy
    redirect_to locations_url, notice: "Location was successfully destroyed."
  end

  private

  def set_location
    @location = Location.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to locations_url, alert: "Location not found."
  end

  def location_params
    params.require(:location).permit(
      :name, :address, :latitude, :longitude, :description,
      activity_names: [], amenity_names: [], images: [], remove_images: []
    )
  end

  def assign_attributes_to_location
    # Assign activities
    if params[:location][:activity_names].present?
      activities = Attribute.where(name: params[:location][:activity_names], category: "Activity")
      @location.activities = activities
    else
      @location.activities.clear
    end

    # Assign amenities
    if params[:location][:amenity_names].present?
      amenities = Attribute.where(name: params[:location][:amenity_names], category: "Amenity")
      @location.amenities = amenities
    else
      @location.amenities.clear
    end
  end
end
