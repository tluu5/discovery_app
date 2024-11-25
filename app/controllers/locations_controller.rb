class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  
    # Filter by activity
    if params[:activities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(attributes: { name: params[:activities], category: 'Activity' })
                             .distinct
    end
  
    # Filter by amenities
    if params[:amenities].present?
      @locations = @locations.joins(location_attributes: :feature)
                             .where(attributes: { name: params[:amenities], category: 'Amenity' })
                             .distinct
    end
  
    # Search by name
    if params[:search].present?
      @locations = @locations.where("name ILIKE ?", "%#{params[:search]}%")
    end
  end  

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find(params[:id])
    @map_data = { lat: @location.latitude, lng: @location.longitude }
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)
  
    respond_to do |format|
      if @location.save
        assign_attributes_to_location
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end  

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        assign_attributes_to_location
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end  

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude, :description)
  end

  def assign_attributes_to_location
    if params[:location][:activities].present?
      # Find or create activities based on the provided names
      activities = Attribute.where(name: params[:location][:activities], category: 'Activity')
      @location.activities = activities
    else
      @location.activities = [] # Clear all activities if none are selected
    end
  
    if params[:location][:amenities].present?
      # Find or create amenities based on the provided names
      amenities = Attribute.where(name: params[:location][:amenities], category: 'Amenity')
      @location.amenities = amenities
    else
      @location.amenities = [] # Clear all amenities if none are selected
    end
  end
end
