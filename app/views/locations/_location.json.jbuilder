json.extract! location, :id, :name, :address, :latitude, :longitude, :description, :created_at, :updated_at
json.url location_url(location, format: :json)
