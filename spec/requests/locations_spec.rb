require "rails_helper"

RSpec.describe "Locations", type: :request do
  let!(:hiking_location) { create(:location, name: "Mountain Hike") }
  let!(:beach_location) { create(:location, name: "Sunny Beach") }
  let!(:amenity) { create(:attribute, name: "Parking", category: "Amenity") }
  
  describe "GET /locations" do
    it "filters locations by name" do
      get locations_path, params: { search: "Mountain" }
      expect(response.body).to include("Mountain Hike")
      expect(response.body).not_to include("Sunny Beach")
    end
  end

  describe "Locations Performance", type: :request do
    it "loads the index page within acceptable time" do
      start_time = Time.now
      get locations_path
      end_time = Time.now
  
      duration = end_time - start_time
      expect(response).to have_http_status(:ok)
      expect(duration).to be < 1.0 # Expect the response to be under 1 second
    end
  end
end
