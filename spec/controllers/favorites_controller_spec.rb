require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create(:user) }
  let(:location) { create(:location) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'adds a location to favorites' do
      post :create, params: { location_id: location.id }
      expect(response).to redirect_to(favorites_path)
      expect(flash[:success]).to eq('Location added to favorites.')
    end

    it 'does not add duplicate favorites' do
      create(:favorite, user: user, location: location)
      post :create, params: { location_id: location.id }
      expect(flash[:notice]).to eq('Location already in your favorites.')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a location from favorites' do
      favorite = create(:favorite, user: user, location: location)
      delete :destroy, params: { location_id: location.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Location removed from your favorites.')
    end
  end
end
