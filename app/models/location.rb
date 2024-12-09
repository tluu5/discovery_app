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
  attr_accessor :remove_images

  # Associations
  has_many :favorites, dependent: :destroy
  has_many :location_attributes, dependent: :destroy

  # Associations for features, activities, and amenities
  has_many :features, through: :location_attributes, source: :feature
  has_many :activities, -> { where(category: 'Activity') }, through: :location_attributes, source: :feature
  has_many :amenities, -> { where(category: 'Amenity') }, through: :location_attributes, source: :feature

  # Validations for core attributes
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Scopes for filtering
  scope :by_activity, ->(activity) {
    joins(location_attributes: :feature)
      .where(features: { name: activity, category: "Activity" })
      .distinct
  }

  scope :by_amenity, ->(amenity) {
    joins(location_attributes: :feature)
      .where(features: { name: amenity, category: "Amenity" })
      .distinct
  }

  scope :search_name, ->(search_term) {
    sanitized_search = ActiveRecord::Base.sanitize_sql_like(search_term)
    where("name ILIKE ?", "%#{sanitized_search}%")
  }

  # Optional description validation
  validates :description, length: { maximum: 500 }, allow_blank: true

  paginates_per 10 # Number of results per page

  before_save :remove_selected_images

  private

  def remove_selected_images
    return if remove_images.blank?

    remove_images.each do |image_id|
      images.find_by(id: image_id)&.destroy
    end
  end
end
