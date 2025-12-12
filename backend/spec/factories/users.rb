FactoryBot.define do
  factory :user do
    username { "TestName" }

    sequence(:email) { |n| "user#{n}@example.com" }

    password { "testpass" }
  end
end
