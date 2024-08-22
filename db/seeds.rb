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
    password: 'password',
    password_confirmation: 'password'
  )
end

# Placeholder image URLs
placeholder_images = [
  "https://upload.wikimedia.org/wikipedia/commons/4/41/Left_side_of_Flying_Pigeon.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/a/a7/Ordinary_bicycle01.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/5/5c/Ant%C3%B4nio%2C_Lu%C3%ADs_and_Pedro.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/8/8d/Draisine_or_Laufmaschine%2C_around_1820._Archetype_of_the_Bicycle._Pic_01.jpg",
]

# Hardcoded addresses with their respective coordinates
addresses_with_coordinates = [
  { address: "Pariser Platz, Berlin", latitude: 52.5158405, longitude: 13.3794655 },
  { address: "Marienplatz 1, München", latitude: 48.137412, longitude: 11.574726 },
  { address: "Domkloster 4, Köln", latitude: 50.940959, longitude: 6.957464 },
  { address: "Schlosshof 1, Heidelberg", latitude: 47.304736, longitude: 16.442308 },
  { address: "Platz der Deutschen Einheit 1, Hamburg", latitude: 53.551086, longitude: 9.993682 }
]

# Create Bikes
6.times do |i|
  location = addresses_with_coordinates.sample

  bike = Bike.create!(
    price: rand(50..150),
    description: Faker::Lorem.sentence(word_count: 10),
    address: location[:address], # Use the address
    latitude: location[:latitude], # Use the hardcoded latitude
    longitude: location[:longitude], # Use the hardcoded longitude
    user: users[i % 3] # Assign bikes to users in a round-robin fashion
  )

  # Attach random images to each bike
  3.times do
    file = URI.open(placeholder_images.sample)
    bike.photos.attach(io: file, filename: "bike#{i}.png", content_type: 'image/png')
  end
end

puts "Seeding completed successfully!"
