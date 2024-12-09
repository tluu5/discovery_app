module Admin
  class AttributesController < ApplicationController
    module Admin
      class AttributesController < ApplicationController
        before_action :set_attribute, only: [:show, :edit, :update, :destroy]

        def index
          @attributes = Attribute.all
        end

        def show; end

        def new
          @attribute = Attribute.new
        end

        def create
          @attribute = Attribute.new(attribute_params)
          if @attribute.save
            redirect_to admin_attributes_path, notice: "Attribute was successfully created."
          else
            flash.now[:alert] = "Failed to create attribute."
            render :new
          end
        end

        def edit; end

        def update
          if @attribute.update(attribute_params)
            redirect_to admin_attributes_path, notice: "Attribute was successfully updated."
          else
            flash.now[:alert] = "Failed to update attribute."
            render :edit
          end
        end

        def destroy
          @attribute.destroy
          redirect_to admin_attributes_path, notice: "Attribute was successfully deleted."
        end

        private

        def set_attribute
          @attribute = Attribute.find(params[:id])
        end

        def attribute_params
          params.require(:attribute).permit(:name, :category)
        end
      end
    end
  end
end
