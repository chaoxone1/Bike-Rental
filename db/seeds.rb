require 'open-uri'

# Clear existing data
Booking.destroy_all
Bike.destroy_all
User.destroy_all

# Create Users
user1 = User.create!(
  email: 'adrien.kropfeld@googlemail.com',
  password: 'password',
  password_confirmation: 'password'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password',
  password_confirmation: 'password'
)

user3 = User.create!(
  email: 'user3@example.com',
  password: 'password',
  password_confirmation: 'password'
)

user4 = User.create!(
  email: 'danmuller.dev.98@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)
user5 = User.create!(
  email: 'distadiomichele93@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)
user6 = User.create!(
  email: 'keno.mehic10@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)
user7 = User.create!(
  email: 'armankurtovic01@gmail.com',
  password: 'password',
  password_confirmation: 'password'
)

# Placeholder image URLs
image_cube1 = "https://images.lucky-bike.de/out/pictures/master/product/1/cube-aim-race-olive-n-black-88596-01.jpg?w=3000&h=2000&q=100"
image_cube2 = "https://images.lucky-bike.de/out/pictures/master/product/2/cube-aim-race-29-olive-n-black-88596-02.jpg?w=3000&h=2000&q=100"
image_cube3 = "https://images.lucky-bike.de/out/pictures/master/product/8/cube-aim-race-29-olive-n-black-88596-08.jpg?w=3000&h=2000&q=100"
sushi1 = "https://sushi-bikes.com/cdn/shop/files/maki_cockpit_displayon_new.jpg?v=1722866996&width=823"
sushi2 = "https://sushi-bikes.com/cdn/shop/files/BCN_2024_KEYVISUAL_1_c2b284b2-6e48-423c-b9b8-f38788e30c69.jpg?v=1722866996&width=823"
sushi3 = "https://sushi-bikes.com/cdn/shop/products/rear_light_an_black.jpg?v=1722866996&width=823"

klapprad1 = "https://cdn.fahrrad-xxl.de/media/pimg/813/thumbs/2648261_14353466.jpg"
klapprad2 = "https://cdn.fahrrad-xxl.de/media/pimg/812/thumbs/2696508_14417463.jpg"

image1 = "https://upload.wikimedia.org/wikipedia/commons/4/41/Left_side_of_Flying_Pigeon.jpg"
image2 = "https://upload.wikimedia.org/wikipedia/commons/a/a7/Ordinary_bicycle01.jpg"
image3 = "https://upload.wikimedia.org/wikipedia/commons/5/5c/Ant%C3%B4nio%2C_Lu%C3%ADs_and_Pedro.jpg"
image4 = "https://upload.wikimedia.org/wikipedia/commons/8/8d/Draisine_or_Laufmaschine%2C_around_1820._Archetype_of_the_Bicycle._Pic_01.jpg"

electro1 = "https://www.fahrrad.de/cdn/shop/files/PHO_BIKE_PERS_REVO_RAY-22-HardRayE40-27-deepred__23SALL__23AEPI__23V1.png?v=1719475572&width=1100"
electro2 = "https://www.fahrrad.de/cdn/shop/files/PHO_BIKE_90_RE_RAY-HardRayE40-27-deepred__23SALL__23AEPI__23V1.png?v=1719475572&width=1100"

# Hardcoded addresses with their respective coordinates
address1 = { address: "Pariser Platz, Berlin", latitude: 52.5158405, longitude: 13.3794655 }
address2 = { address: "Marienplatz 1, München", latitude: 48.137412, longitude: 11.574726 }
address3 = { address: "Domkloster 4, Köln", latitude: 50.940959, longitude: 6.957464 }
address4 = { address: "Schlosshof 1, Heidelberg", latitude: 47.304736, longitude: 16.442308 }
address5 = { address: "Platz der Deutschen Einheit 1, Hamburg", latitude: 53.551086, longitude: 9.993682 }

# Create Bikes

bike1 = Bike.create!(
  price: 100,
  description: "A classic bicycle in Berlin.",
  address: address1[:address],
  latitude: address1[:latitude],
  longitude: address1[:longitude],
  user: user1
)
bike1.photos.attach(io: URI.open(image_cube1), filename: "bike1.png", content_type: 'image/png')
bike1.photos.attach(io: URI.open(image_cube2), filename: "bike2.png", content_type: 'image/png')
bike1.photos.attach(io: URI.open(image_cube3), filename: "bike3.png", content_type: 'image/png')

bike2 = Bike.create!(
  price: 80,
  description: "A vintage bike at Marienplatz.",
  address: address2[:address],
  latitude: address2[:latitude],
  longitude: address2[:longitude],
  user: user2
)
bike2.photos.attach(io: URI.open(sushi1), filename: "bike1.png", content_type: 'image/png')
bike2.photos.attach(io: URI.open(sushi2), filename: "bike2.png", content_type: 'image/png')
bike2.photos.attach(io: URI.open(sushi3), filename: "bike3.png", content_type: 'image/png')

bike3 = Bike.create!(
  price: 120,
  description: "A modern bike near Cologne Cathedral.",
  address: address3[:address],
  latitude: address3[:latitude],
  longitude: address3[:longitude],
  user: user3
)
bike3.photos.attach(io: URI.open(klapprad1), filename: "bike1.png", content_type: 'image/png')
bike3.photos.attach(io: URI.open(klapprad2), filename: "bike2.png", content_type: 'image/png')

bike4 = Bike.create!(
  price: 95,
  description: "A comfortable bike at Heidelberg Castle.",
  address: address4[:address],
  latitude: address4[:latitude],
  longitude: address4[:longitude],
  user: user1
)
bike4.photos.attach(io: URI.open(image1), filename: "bike1.png", content_type: 'image/png')
bike4.photos.attach(io: URI.open(image2), filename: "bike2.png", content_type: 'image/png')

bike5 = Bike.create!(
  price: 110,
  description: "A sleek bike in Hamburg.",
  address: address5[:address],
  latitude: address5[:latitude],
  longitude: address5[:longitude],
  user: user2
)
bike5.photos.attach(io: URI.open(image3), filename: "bike1.png", content_type: 'image/png')
bike5.photos.attach(io: URI.open(image4), filename: "bike2.png", content_type: 'image/png')

bike6 = Bike.create!(
  price: 75,
  description: "An affordable bike for daily rides.",
  address: address1[:address],
  latitude: address1[:latitude],
  longitude: address1[:longitude],
  user: user3
)
bike6.photos.attach(io: URI.open(electro1), filename: "bike1.png", content_type: 'image/png')
bike6.photos.attach(io: URI.open(electro2), filename: "bike2.png", content_type: 'image/png')

puts "Seeding completed successfully!"
