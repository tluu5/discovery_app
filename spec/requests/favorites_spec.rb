require "rails_helper"

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:location) { create(:location) }

  before { sign_in(user) }

  describe "POST /favorites" do
    it "adds a location to favorites" do
      post location_favorite_path(location)
      expect(user.favorites.count).to eq(1)
      expect(user.favorites.first.location).to eq(location)
    end

    it "does not allow duplicate favorites" do
      user.favorites.create(location: location)
      post location_favorite_path(location)
      expect(user.favorites.count).to eq(1)
    end
  end

  describe "DELETE /favorites" do
    it "removes a location from favorites" do
      favorite = user.favorites.create(location: location)
      delete location_favorite_path(location)
      expect(user.favorites.count).to eq(0)
    end
  end
end
