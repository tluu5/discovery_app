# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  description :string
#  latitude    :float            not null
#  longitude   :float            not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_locations_on_name  (name) UNIQUE
#
class Location < ApplicationRecord
  has_many :favorites, class_name: "Favorite", foreign_key: "location_id", dependent: :destroy
  has_many :location_attributes, dependent: :destroy
  has_many :features, through: :location_attributes, source: :feature

  has_many :activities, -> { where(attributes: { category: 'Activity' }) }, through: :location_attributes, source: :feature
  has_many :amenities, -> { where(attributes: { category: 'Amenity' }) }, through: :location_attributes, source: :feature

  # Ensure name, address, latitude, and longitude are present
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Ensure description is optional but limited in length if provided
  validates :description, length: { maximum: 500 }
end
