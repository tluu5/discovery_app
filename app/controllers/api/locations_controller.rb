module Api
  class Api::LocationsController < ApplicationController
    def index
      locations = Location.all
  
      if params[:search].present?
        if params[:exact] == "true"
          locations = locations.where(name: params[:search])
        else
          locations = locations.where("name ILIKE ?", "%#{params[:search]}%")
        end
      end
  
      render json: locations, status: :ok
    end
  end  
end
