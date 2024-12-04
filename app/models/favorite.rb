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
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (user_id => users.id)
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :location

  # Ensure user and location are present
  validates :user_id, presence: true
  validates :location_id, presence: true

  # Ensure a user cannot favorite the same location multiple times
  validates :user_id, uniqueness: { scope: :location_id, message: "You have already favorited this location" }
end
