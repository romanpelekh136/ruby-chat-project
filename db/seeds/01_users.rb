puts "Seeding Users..."

User.find_or_create_by!(email: "admin@example.com") do |u|
  u.username = "Admin"
  u.password = "password123"
end

10.times do
  User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end
puts "Created 11 Users."
