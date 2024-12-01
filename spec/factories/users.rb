FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" } # Unique emails
    sequence(:username) { |n| "username#{n}" }     # Unique usernames
    password { "SecureP@ssw0rd!" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
