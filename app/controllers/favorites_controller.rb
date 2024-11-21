class FavoritesController < ApplicationController
  before_action :authenticate_user!

  # GET /favorites or /favorites.json
  def index
    @favorites = current_user.favorites.includes(:location) # Load all favorite locations for the logged-in user
  end

  # GET /favorites/1 or /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
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
    redirect_to locations_path
  end  

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to favorite_url(@favorite), notice: "Favorite was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite = current_user.favorites.find_by(location_id: params[:location_id])
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
      @location = Location.find(params[:location_id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :location_id)
    end
end
