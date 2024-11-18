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
  has_many :location_attributes, class_name: "LocationAttribute", foreign_key: "attribute_id", dependent: :destroy
  has_many :locations, through: :location_attributes

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :category, presence: true
end
