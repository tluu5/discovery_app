class LocationAttributesController < ApplicationController
  before_action :set_location_attribute, only: %i[ show edit update destroy ]

  # GET /location_attributes or /location_attributes.json
  def index
    @location_attributes = LocationAttribute.all
  end

  # GET /location_attributes/1 or /location_attributes/1.json
  def show
  end

  # GET /location_attributes/new
  def new
    @location_attribute = LocationAttribute.new
  end

  # GET /location_attributes/1/edit
  def edit
  end

  # POST /location_attributes or /location_attributes.json
  def create
    @location_attribute = LocationAttribute.new(location_attribute_params)

    respond_to do |format|
      if @location_attribute.save
        format.html { redirect_to location_attribute_url(@location_attribute), notice: "Location attribute was successfully created." }
        format.json { render :show, status: :created, location: @location_attribute }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_attributes/1 or /location_attributes/1.json
  def update
    respond_to do |format|
      if @location_attribute.update(location_attribute_params)
        format.html { redirect_to location_attribute_url(@location_attribute), notice: "Location attribute was successfully updated." }
        format.json { render :show, status: :ok, location: @location_attribute }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_attributes/1 or /location_attributes/1.json
  def destroy
    @location_attribute.destroy!

    respond_to do |format|
      format.html { redirect_to location_attributes_url, notice: "Location attribute was successfully destroyed." }
      format.json { head :no_content }
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
