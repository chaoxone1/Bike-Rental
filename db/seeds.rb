require 'faker'
require 'open-uri'

# Clear existing data
Booking.destroy_all
Bike.destroy_all
User.destroy_all

# Create Users
users = []
3.times do |i|
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: 'password', # Use a default password for all users
    password_confirmation: 'password'
  )
end

# Placeholder image URLs
placeholder_images = [
  "https://via.placeholder.com/300x200.png?text=Bike+1",
  "https://via.placeholder.com/300x200.png?text=Bike+2",
  "https://via.placeholder.com/300x200.png?text=Bike+3",
  "https://via.placeholder.com/300x200.png?text=Bike+4",
  "https://via.placeholder.com/300x200.png?text=Bike+5"
]

# Create Bikes
6.times do |i|
  bike = Bike.create!(
    price: rand(50..150),
    description: Faker::Lorem.sentence(word_count: 10),
    location: Faker::Address.city,
    user: users[i % 3] # Assign bikes to users in a round-robin fashion
  )

  # Attach random images to each bike
  3.times do
    file = URI.open(placeholder_images.sample)
    bike.photos.attach(io: file, filename: "bike#{i}.png", content_type: 'image/png')
  end
end

# Create Bookings
10.times do |i|
  start_date = Faker::Date.between(from: 2.days.ago, to: Date.today)
  end_date = start_date + rand(1..7).days

  Booking.create!(
    user: users.sample,
    bike: Bike.all.sample,
    start_date: start_date,
    end_date: end_date,
    status: ['pending', 'confirmed', 'canceled'].sample
  )
end

puts "Seed data created successfully!"
