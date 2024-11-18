# == Schema Information
#
# Table name: attributes
#
#  id         :bigint           not null, primary key
#  category   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Attribute < ApplicationRecord
  has_many :location_activities, class_name: "LocationAttribute", foreign_key: "attribute_id", dependent: :destroy

  validates :category, presence: true
  validates :name, presence: true
end
