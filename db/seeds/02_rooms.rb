puts "Seeding Rooms..."

users = User.all.to_a
if users.empty?
  raise "No users found; run db/seeds/01_users.rb before seeding rooms"
end

5.times do
  Room.create!(
    name: Faker::Hobby.activity,
    user: users.sample
  )
end
puts "Created 8 Rooms."
