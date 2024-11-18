# == Schema Information
#
# Table name: favorites
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  user_id     :integer
#
class Favorite < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :location, required: true, class_name: "Location", foreign_key: "location_id"
end
