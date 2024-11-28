# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  city        :string           not null
#  description :string
#  latitude    :float            not null
#  longitude   :float            not null
#  name        :string           not null
#  state       :string           not null
#  zip_code    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_locations_on_city      (city)
#  index_locations_on_name      (name) UNIQUE
#  index_locations_on_state     (state)
#  index_locations_on_zip_code  (zip_code)
#
class Location < ApplicationRecord
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :location_attributes, dependent: :destroy
  has_many :features, through: :location_attributes, source: :feature

  # Activities and Amenities associations
  has_many :activities, -> { where(attributes: { category: 'Activity' }) }, through: :location_attributes, source: :feature
  has_many :amenities, -> { where(attributes: { category: 'Amenity' }) }, through: :location_attributes, source: :feature

  # Ensure name, address, latitude, and longitude are present
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :city, presence: true
  validates :state, presence: true, format: { with: /\A[A-Z]{2}\z/, message: "should be two uppercase letters" }
  validates :zip_code, presence: true, format: { with: /\A\d{5}(-\d{4})?\z/, message: "should be a valid US ZIP code format" }

  # Ensure description is optional but limited in length if provided
  validates :description, length: { maximum: 500 }

   # Geocode
   geocoded_by :full_address
   after_validation :geocode, if: ->(obj){ obj.address_changed? || obj.city_changed? || obj.state_changed? || obj.zip_code_changed? }
 
   # Custom method to combine address fields
   def full_address
     "#{address}, #{city}, #{state}, #{zip_code}"
   end
end
