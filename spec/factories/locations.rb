FactoryBot.define do
  factory :location do
    name { "Test Location" }
    address { "123 Test St" }
    latitude { 40.7128 }
    longitude { -74.0060 }
    description { "A beautiful test location" }
  end
end
