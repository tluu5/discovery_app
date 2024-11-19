# == Schema Information
#
# Table name: favorites
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_favorites_on_user_id_and_location_id  (user_id,location_id) UNIQUE
#
class Favorite < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :location, required: true, class_name: "Location", foreign_key: "location_id"

  # Ensure user and location are present
  validates :user_id, presence: true
  validates :location_id, presence: true

  # Ensure a user cannot favorite the same location multiple times
  validates :location_id, uniqueness: { scope: :location_id, message: "You have already favorited this location" } 
end
