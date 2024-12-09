# == Schema Information
#
# Table name: attributes
#
#  id         :bigint           not null, primary key
#  category   :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_attributes_on_category  (category)
#  index_attributes_on_name      (name) UNIQUE
#
class Attribute < ApplicationRecord
  has_many :location_attributes, foreign_key: 'feature_id', dependent: :destroy
  has_many :locations, through: :location_attributes

  # Ensure name and category are present
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :category, presence: true
end
