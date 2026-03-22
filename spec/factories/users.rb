FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "TestName#{n}" }

    sequence(:email) { |n| "user#{n}@example.com" }

    password { "testpass" }
  end
end
