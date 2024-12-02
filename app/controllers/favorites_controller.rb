class FavoritesController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :set_favorite, only: [:destroy]

  # GET /favorites
  def index
    @favorites = current_user.favorites.includes(:location)
  end

  # POST /favorites
  def create
    location = Location.find(params[:location_id])
    if current_user.favorites.exists?(location_id: location.id)
      flash[:notice] = "Location already in your favorites."
    else
      favorite = current_user.favorites.new(location: location)
      if favorite.save
        flash[:success] = "Location added to favorites."
      else
        flash[:error] = "Could not add to favorites."
      end
    end
    redirect_to favorites_path
  end

  # DELETE /favorites/:id
  def destroy
    if @favorite
      @favorite.destroy
      flash[:notice] = "Location removed from your favorites."
    else
      flash[:alert] = "Location not found in your favorites."
    end
    redirect_to favorites_path # Ensure it redirects here
  end  

  private

  def set_favorite
    @favorite = current_user.favorites.find_by(location_id: params[:location_id])
  end

  def favorite_params
    params.require(:favorite).permit(:location_id)
  end
end
