class AttributesController < ApplicationController
  before_action :set_attribute, only: %i[show edit update destroy]

  def available
    @attributes = Attribute.all
    render json: @attributes
  end  

  # GET /attributes or /attributes.json
  def index
    @attributes = Attribute.all
  end

  # POST /attributes or /attributes.json
  def create
    @attribute = Attribute.new(attribute_params)

    if @attribute.save
      redirect_to attribute_url(@attribute), notice: "Attribute was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attributes/1 or /attributes/1.json
  def update
    if @attribute.update(attribute_params)
      redirect_to attribute_url(@attribute), notice: "Attribute was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /attributes/1 or /attributes/1.json
  def destroy
    if @attribute.destroy
      redirect_to attributes_url, notice: "Attribute was successfully destroyed."
    else
      redirect_to attributes_url, alert: "Failed to delete attribute. It might be associated with other records."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attribute
    @attribute = Attribute.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attribute_params
    params.require(:attribute).permit(:name, :category)
  end
end
