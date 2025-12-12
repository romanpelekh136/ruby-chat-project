FactoryBot.define do
  factory :message do
    body { "MyText" }
    user
    room
  end
end
