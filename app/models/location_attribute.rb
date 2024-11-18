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
  belongs_to :activity, required: true, class_name: "Attribute", foreign_key: "attribute_id"
end
