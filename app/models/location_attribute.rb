# == Schema Information
#
# Table name: location_attributes
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  feature_id  :integer          not null
#  location_id :integer          not null
#
# Indexes
#
#  index_location_attributes_on_location_id_and_feature_id  (location_id,feature_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (feature_id => attributes.id)
#  fk_rails_...  (location_id => locations.id)
#
class LocationAttribute < ApplicationRecord
  # Associations
  belongs_to :location
  belongs_to :feature, class_name: 'Attribute', foreign_key: 'feature_id'

  # Ensure location and feature (attribute) are present
  validates :location_id, presence: true
  validates :feature, presence: true

  # Ensure a location cannot have duplicate attributes
  validates :feature_id, uniqueness: { scope: :location_id, message: "This attribute is already associated with the location" }
end
