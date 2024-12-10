class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  include ImageManagementHelper

  def index
    @activities = Attribute.where(category: 'activity').pluck(:name)
    @amenities = Attribute.where(category: 'amenity').pluck(:name)
  
    @locations = LocationFilterService.new(Location.all, params).call.page(params[:page]).per(10)
  
    respond_to do |format|
      format.html
      format.json { render json: @locations, status: :ok }
    end
  end  

  def show
    @map_data = { lat: @location.latitude, lng: @location.longitude }
  end

  def new
    @location = Location.new
  end

  def edit; end

  def create
    @location = Location.new(location_params)

    if @location.save
      AttributeAssignmentService.new(@location, params[:location]).call
      redirect_to location_url(@location), notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    params[:location].delete(:images) if params[:location][:images].blank?

    if @location.update(location_params)
      AttributeAssignmentService.new(@location, params[:location]).call
      remove_images(@location, params[:location][:remove_images])
      redirect_to location_url(@location), notice: "Location was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

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
end
