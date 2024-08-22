require 'faker'
require 'open-uri'
require 'json'
require 'net/http'
require 'cgi'

# Load environment variables
MAPBOX_API_KEY = ENV['MAPBOX_API_KEY']

# Method to geocode an address using Mapbox
def geocode_address(address)
  # Use CGI.escape to properly encode the address
  encoded_address = CGI.escape(address)
  url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{encoded_address}.json?access_token=#{MAPBOX_API_KEY}"
  uri = URI(url)
  response = Net::HTTP.get(uri)

  begin
    parsed_response = JSON.parse(response)
    puts "Mapbox API response for address '#{address}':"
    puts JSON.pretty_generate(parsed_response) # Print the response in a pretty format
    parsed_response
  rescue JSON::ParserError => e
    puts "Failed to parse JSON response for address '#{address}': #{e.message}"
    puts "Raw response: #{response}"
    nil
  end
end

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
  "https://upload.wikimedia.org/wikipedia/commons/4/41/Left_side_of_Flying_Pigeon.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/a/a7/Ordinary_bicycle01.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/5/5c/Ant%C3%B4nio%2C_Lu%C3%ADs_and_Pedro.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/8/8d/Draisine_or_Laufmaschine%2C_around_1820._Archetype_of_the_Bicycle._Pic_01.jpg",
]

placeholder_addresses = [
  "Pariser Platz, Berlin",
  "Marienplatz 1, München",
  "Domkloster 4, Köln",
  "Schlosshof 1, Heidelberg",
  "Platz der Deutschen Einheit 1, Hamburg"
]

# Create Bikes
6.times do |i|
  address = placeholder_addresses.sample

  # Call the geocoding method and log the response
  geocode_response = geocode_address(address)

  bike = Bike.create!(
    price: rand(50..150),
    description: Faker::Lorem.sentence(word_count: 10),
    address: address, # Assign the address
    user: users[i % 3] # Assign bikes to users in a round-robin fashion
  )

  # Attach random images to each bike
  3.times do
    file = URI.open(placeholder_images.sample)
    bike.photos.attach(io: file, filename: "bike#{i}.png", content_type: 'image/png')
  end

  sleep 3 # Add a 3-second delay between each bike creation
end

# Create Bookings
# 10.times do |i|
#   start_date = Faker::Date.between(from: 2.days.ago, to: Date.today)
#   end_date = start_date + rand(1..7).days

#   Booking.create!(
#     user: users.sample,
#     bike: Bike.all.sample,
#     start_date: start_date,
#     end_date: end_date,
#     status: ['pending', 'booked', 'new'].sample
#   )
# end

puts "Seed data created successfully!"
