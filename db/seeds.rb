# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

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

# Create Bikes
bikes = []
6.times do |i|
  bikes << Bike.create!(
    price: rand(50..150),
    description: Faker::Lorem.sentence(word_count: 10),
    location: Faker::Address.city,
    user: users[i % 3] # Assign bikes to users in a round-robin fashion
  )
end

# Create Bookings
10.times do |i|
  start_date = Faker::Date.between(from: 2.days.ago, to: Date.today)
  end_date = start_date + rand(1..7).days

  Booking.create!(
    user: users.sample,
    bike: bikes.sample,
    start_date: start_date,
    end_date: end_date,
    status: ['pending', 'confirmed', 'canceled'].sample
  )
end

puts "Seed data created successfully!"
