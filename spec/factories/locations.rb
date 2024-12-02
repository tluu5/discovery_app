# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  description :string
#  latitude    :float            not null
#  longitude   :float            not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_locations_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" } # Ensure unique names
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
