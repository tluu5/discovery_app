require "rails_helper"

RSpec.describe LocationsController, type: :controller do
  let(:location) { create(:location) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns the requested location" do
      get :show, params: { id: location.id }
      expect(assigns(:location)).to eq(location)
    end
  end

  describe "POST #create" do
    it "creates a new location" do
      expect {
        post :create, params: { location: attributes_for(:location) }
      }.to change(Location, :count).by(1)
    end

    it "does not create a location with invalid data" do
      expect {
        post :create, params: { location: { name: "" } }
      }.not_to change(Location, :count)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the location" do
      location = create(:location)
      expect {
        delete :destroy, params: { id: location.id }
      }.to change(Location, :count).by(-1)
    end
  end
end
