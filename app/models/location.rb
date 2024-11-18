# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :string
#  latitude    :float
#  longitude   :float
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Location < ApplicationRecord
  has_many :favorites, class_name: "Favorite", foreign_key: "location_id", dependent: :destroy
  has_many :location_attributes, class_name: "LocationAttribute", foreign_key: "location_id", dependent: :destroy
  has_many :users, through: :favorites
  has_many :attributes, through: :location_attributes

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: :true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
end
