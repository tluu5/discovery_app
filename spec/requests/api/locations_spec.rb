require 'rails_helper'

RSpec.describe "API Locations", type: :request do
  describe "GET /api/locations" do
    before do
      create(:location, name: 'Beach')
      create(:location, name: 'Mountain')
      create(:location, name: 'Beachfront') # Similar name for unintended match
    end

    it "returns all locations as JSON" do
      get "/api/locations"

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(Location.count) # Verify all locations
      expect(parsed_response.first).to include("name", "address", "latitude", "longitude")
    end

    context 'when filtering by a name' do
      it 'returns matching locations' do
        get '/api/locations', params: { search: 'Beach' }

        expect(response).to have_http_status(:ok)
        result = JSON.parse(response.body)

        expect(result.length).to eq(2) # Matches "Beach" and "Beachfront"
        expect(result.map { |r| r['name'] }).to include('Beach', 'Beachfront')
      end

      it 'returns exact matches only when specified' do
        get '/api/locations', params: { search: 'Beach', exact: 'true' }

        expect(response).to have_http_status(:ok)
        result = JSON.parse(response.body)

        expect(result.length).to eq(1) # Matches only "Beach"
        expect(result.first['name']).to eq('Beach')
      end
    end
  end
end
