module Api  # It seems like all locations_controllers can be unified and the different data can be returned using pundit.
  class Api::LocationsController < ApplicationController
    def index
      if params[:page].present? && params[:per_page].present?
        page = params[:page].to_i
        per_page = params[:per_page].to_i
    
        if page <= 0 || per_page <= 0
          render json: { error: "Invalid pagination parameters" }, status: :bad_request and return
        end
      end
    
      locations = Location.all
    
      if params[:search].present?
        if params[:exact] == "true"
          locations = locations.where(name: params[:search])
        else
          locations = locations.where("name ILIKE ?", "%#{params[:search]}%")
        end
      end
    
      locations = locations.order(:name) if params[:sort].present?
    
      if params[:page].present? && params[:per_page].present?
        locations = locations.page(params[:page]).per(params[:per_page])
      end
    
      render json: locations, status: :ok
    end        
  end   
end
