require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create(:user) }
  let(:location) { create(:location) }

  describe 'POST #create' do
    context 'when logged in' do
      before do
        sign_in user
      end

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

    context 'when not logged in' do
      it 'does not allow creating a favorite' do
        post :create, params: { location_id: location.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      before do
        sign_in user
      end

      it "removes a location from favorites" do
        favorite = create(:favorite, user: user, location: location)
        delete :destroy, params: { location_id: location.id }
        expect(response).to redirect_to(favorites_path)
        expect(flash[:notice]).to eq("Location removed from your favorites.")
      end      
    end

    context 'when not logged in' do
      it 'does not allow removing a favorite' do
        delete :destroy, params: { location_id: location.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
