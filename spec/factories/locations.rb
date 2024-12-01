FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" } # Ensure unique names
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
