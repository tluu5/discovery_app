# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :string
#  latitude    :integer
#  longitude   :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Location < ApplicationRecord
  has_many :favorites, class_name: "Favorite", foreign_key: "location_id", dependent: :destroy
  has_many :location_activities, class_name: "LocationAttribute", foreign_key: "location_id", dependent: :destroy
end
