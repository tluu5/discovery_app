class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations
  def index
    @activities = Attribute.where(category: 'activity').pluck(:name)
    @amenities = Attribute.where(category: 'amenity').pluck(:name)
  
    @locations = Location.all
  
    # Filter by activities
    if params[:activities].present?
      @locations = @locations.joins(:location_attributes).where(location_attributes: { feature_id: Attribute.where(name: params[:activities], category: 'activity').pluck(:id) }).distinct
    end
  
    # Filter by amenities
    if params[:amenities].present?
      @locations = @locations.joins(:location_attributes).where(location_attributes: { feature_id: Attribute.where(name: params[:amenities], category: 'amenity').pluck(:id) }).distinct
    end
  
    # Search by name
    if params[:search].present?
      sanitized_search = ActiveRecord::Base.sanitize_sql_like(params[:search])
      @locations = @locations.where("name ILIKE ?", "%#{sanitized_search}%")
    end
  
    @locations = @locations.page(params[:page]).per(10)
  
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
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/:id
  def update
    # Preserve existing images if no new images are uploaded
    if params[:location][:images].nil? || params[:location][:images].empty?
      params[:location].delete(:images) # Prevent overwriting existing images
    end
  
    if @location.update(location_params)
      assign_attributes_to_location
  
      # Remove explicitly selected images
      if params[:location][:remove_images].present?
        Rails.logger.debug "Removing images: #{params[:location][:remove_images]}"
        params[:location][:remove_images].each do |image_id|
          image = @location.images.find_by(id: image_id)
          if image
            Rails.logger.debug "Purging image: #{image.filename}"
            image.purge
          else
            Rails.logger.debug "Image ID #{image_id} not found for removal."
          end
        end
      end
  
      Rails.logger.debug "Current images after update: #{@location.images.map(&:filename)}"
  
      redirect_to location_url(@location), notice: "Location was successfully updated."
    else
      Rails.logger.debug "Location update failed. Errors: #{@location.errors.full_messages}"
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
      :name, :address, :latitude, :longitude, :description, images: [], remove_images: []
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
