# == Schema Information
#
# Table name: location_attributes
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  attribute_id :integer
#  location_id  :integer
#
class LocationAttribute < ApplicationRecord
  belongs_to :location, required: true, class_name: "Location", foreign_key: "location_id"
  belongs_to :attribute, required: true, class_name: "Attribute", foreign_key: "attribute_id"

  validates :location_id, presence: true
  validates :attribute_id, presence: true
  validates :attribute_id, uniqueness: { scope: :location_id, message: "This attribute is already associated with the location" }
end
