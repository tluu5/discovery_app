FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    username { "TestUser" }
    password { "Password1!" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
