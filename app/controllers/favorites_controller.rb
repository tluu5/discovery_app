class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite, only: [:destroy]

  # GET /favorites or /favorites.json
  def index
    @favorites = current_user.favorites.includes(:location) # Load all favorite locations for the logged-in user
  end

  # POST /favorites or /favorites.json
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
    redirect_to favorites_path # Redirect to the favorites list
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    if @favorite
      @favorite.destroy
      flash[:notice] = "Location removed from your favorites."
    else
      flash[:alert] = "Location not found in your favorites."
    end
    redirect_back(fallback_location: root_path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = current_user.favorites.find_by(location_id: params[:location_id])
  end

  # Only allow a list of trusted parameters through.
  def favorite_params
    params.require(:favorite).permit(:location_id) # Removed :user_id for security
  end
end
