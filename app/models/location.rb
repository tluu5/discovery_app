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
  has_many :location_attributes, class_name: "LocationAttribute", foreign_key: "location_id", dependent: :destroy
  has_many :users, through: :favorites
  has_many :features, through: :location_attributes, source: :feature

  # Ensure name, address, latitude, and longitude are present
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: :true, numericality: true

  # Ensure description is optional but limited in length if provided
  validates :description, presence: true, length: { maximum: 500 }
end
