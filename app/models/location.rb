# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  description :string           not null
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
  # Attachments
  has_many_attached :images

  # Associations
  has_many :favorites, dependent: :destroy
  has_many :location_attributes, dependent: :destroy

  # Associations for features, activities, and amenities
  has_many :features, through: :location_attributes, source: :feature

  # Validations for core attributes
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Optional description validation
  validates :description, length: { maximum: 500 }, allow_blank: true
end
