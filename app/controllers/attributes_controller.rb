class AttributesController < ApplicationController
  before_action :set_attribute, only: %i[edit update destroy]

  def available
    @attributes = Attribute.all
    render json: @attributes
  end  

  # GET /attributes
  def index
    @attributes = Attribute.all
  end

  # GET /attributes/new
  def new
    @attribute = Attribute.new
  end

  # POST /attributes
  def create
    @attribute = Attribute.new(attribute_params)

    if @attribute.save
      redirect_to attributes_path, notice: "Attribute was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /attributes/:id/edit
  def edit
  end

  # PATCH/PUT /attributes/:id
  def update
    if @attribute.update(attribute_params)
      redirect_to attributes_path, notice: "Attribute was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /attributes/:id
  def destroy
    if @attribute.destroy
      redirect_to attributes_path, notice: "Attribute was successfully destroyed."
    else
      redirect_to attributes_path, alert: "Failed to delete attribute. It might be associated with other records."
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
