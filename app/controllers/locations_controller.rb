class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations
  def index
    @locations = Location.all

    # Filter by activity
    if params[:activities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(attributes: { name: params[:activities], category: "Activity" })
                             .distinct
    end

    # Filter by amenities
    if params[:amenities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(attributes: { name: params[:amenities], category: "Amenity" })
                             .distinct
    end

    # Search by name
    if params[:search].present?
      @locations = @locations.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # Debugging Logs
    logger.debug "Filtered Locations SQL Query: #{@locations.to_sql}"
    logger.debug "Filtered Locations Results: #{@locations.to_a}"
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
      assign_attributes_to_location
      redirect_to location_url(@location), notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/:id
  def update
    if @location.update(location_params)
      assign_attributes_to_location

      # Remove selected images
      if params[:location][:remove_images].present?
        params[:location][:remove_images].each do |image_id|
          image = @location.images.find_by(id: image_id)
          image&.purge
        end
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
  end

  def location_params
    params.require(:location).permit(
      :name, :address, :latitude, :longitude, :description,
      activities: [], amenities: [], images: [],
    )
  end

  def assign_attributes_to_location
    # Assign activities
    if params[:location][:activities].present?
      activities = Attribute.where(name: params[:location][:activities], category: "Activity")
      @location.activities = activities
    else
      @location.activities.clear
    end

    # Assign amenities
    if params[:location][:amenities].present?
      amenities = Attribute.where(name: params[:location][:amenities], category: "Amenity")
      @location.amenities = amenities
    else
      @location.amenities.clear
    end
  end
end
