class LocationAttributesController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :set_location_attribute, only: %i[show edit update destroy]

  # GET /location_attributes or /location_attributes.json
  def index
    @location_attributes = LocationAttribute.all
  end

  # POST /location_attributes or /location_attributes.json
  def create
    @location_attribute = LocationAttribute.new(location_attribute_params)

    if @location_attribute.save
      redirect_to location_attribute_url(@location_attribute), notice: "Location attribute was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /location_attributes/1 or /location_attributes/1.json
  def update
    if @location_attribute.update(location_attribute_params)
      redirect_to location_attribute_url(@location_attribute), notice: "Location attribute was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /location_attributes/1 or /location_attributes/1.json
  def destroy
    if @location_attribute.destroy
      redirect_to location_attributes_url, notice: "Location attribute was successfully destroyed."
    else
      flash[:alert] = "Unable to delete location attribute."
      redirect_back(fallback_location: location_attributes_url)
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_location_attribute
      @location_attribute = LocationAttribute.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_attribute_params
      params.require(:location_attribute).permit(:location_id, :attribute_id)
    end
end
