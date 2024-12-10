# Clear existing data
User.destroy_all
LocationAttribute.destroy_all
Attribute.destroy_all
Favorite.destroy_all
Location.destroy_all

puts "All data cleared!"

# Create users
users = User.create!([
  { email: 'john.doe@example.com', username: 'johndoe', password: 'Password1!', admin: false },
  { email: 'jane.smith@example.com', username: 'janesmith', password: 'Password2!', admin: false },
  { email: 'admin@example.com', username: 'adminuser', password: 'Password3!', admin: true },
  { email: 'alice.brown@example.com', username: 'alicebrown', password: 'Password4!', admin: false },
  { email: 'bob.jones@example.com', username: 'bobjones', password: 'Password5!', admin: false },
  { email: 'charlie.davis@example.com', username: 'charliedavis', password: 'Password6!', admin: false }
])

puts "Created #{User.count} users!"

# Create attributes with normalized categories
attributes = Attribute.create!([
  { name: 'Hiking', category: 'Activity' },
  { name: 'Fishing', category: 'Activity' },
  { name: 'Camping', category: 'Activity' },
  { name: 'Kayaking', category: 'Activity' },
  { name: 'Picnic Area', category: 'Amenity' },
  { name: 'Hiking Trail', category: 'Amenity' },
  { name: 'Public Restrooms', category: 'Amenity' },
  { name: 'BBQ Grills', category: 'Amenity' },
  { name: 'Dog-Friendly', category: 'Amenity' },
  { name: 'Playground', category: 'Amenity' }
])

puts "Created #{Attribute.count} attributes!"

# Create locations
locations = Location.create!([
  {
    name: 'Lincoln Park',
    address: '2000 N Clark St, Chicago, IL 60614',
    latitude: 41.9214,
    longitude: -87.6513,
    description: 'A beautiful park with trails, picnic spots, and a zoo.'
  },
  {
    name: 'Starved Rock State Park',
    address: '2668 E 875th Rd, Oglesby, IL 61348',
    latitude: 41.3204,
    longitude: -88.9932,
    description: 'Famous for its stunning rock formations and hiking trails.'
  },
  {
    name: 'Montrose Beach',
    address: '4400 N Lake Shore Dr, Chicago, IL 60640',
    latitude: 41.9637,
    longitude: -87.6387,
    description: 'A popular spot for kayaking, fishing, and beach activities.'
  },
  {
    name: 'Grant Park',
    address: '337 E Randolph St, Chicago, IL 60601',
    latitude: 41.8763,
    longitude: -87.6190,
    description: 'Known for its wide open spaces and iconic landmarks like Buckingham Fountain.'
  },
  {
    name: 'Waterfall Glen Forest Preserve',
    address: 'Cass Ave & Bluff Rd, Darien, IL 60561',
    latitude: 41.7458,
    longitude: -87.9955,
    description: 'A preserve with scenic waterfalls and extensive hiking trails.'
  },
  {
    name: 'Indiana Dunes State Park',
    address: '1600 N 25 E, Chesterton, IN 46304',
    latitude: 41.6839,
    longitude: -87.0366,
    description: 'A sandy paradise along Lake Michigan, perfect for camping and hiking.'
  },
  {
    name: 'Millennium Park',
    address: '201 E Randolph St, Chicago, IL 60602',
    latitude: 41.8827,
    longitude: -87.6226,
    description: 'A public park known for the Cloud Gate sculpture and open-air concerts.'
  },
  {
    name: 'Willowbrook Wildlife Center',
    address: '525 S Park Blvd, Glen Ellyn, IL 60137',
    latitude: 41.8712,
    longitude: -88.0637,
    description: 'A rehabilitation center for native wildlife with interactive exhibits.'
  },
  {
    name: 'Morton Arboretum',
    address: '4100 IL-53, Lisle, IL 60532',
    latitude: 41.8167,
    longitude: -88.0678,
    description: 'A nature preserve with themed gardens, trails, and seasonal exhibits.'
  },
  {
    name: 'Navy Pier',
    address: '600 E Grand Ave, Chicago, IL 60611',
    latitude: 41.8917,
    longitude: -87.6077,
    description: 'A bustling waterfront destination with rides, eateries, and entertainment.'
  },
  {
    name: 'Matthiessen State Park',
    address: '2500 IL-178, Oglesby, IL 61348',
    latitude: 41.2851,
    longitude: -89.0113,
    description: 'A park with unique geological formations and scenic hiking trails.'
  }
])

puts "Created #{Location.count} locations!"

# Assign activities and amenities to locations
LocationAttribute.create!([
  { location: locations[0], feature: attributes[0] }, # Lincoln Park: Hiking
  { location: locations[1], feature: attributes[0] }, # Starved Rock: Hiking
  { location: locations[2], feature: attributes[1] }, # Montrose Beach: Fishing
  { location: locations[3], feature: attributes[4] }, # Grant Park: Picnic Area
  { location: locations[4], feature: attributes[5] }, # Waterfall Glen: Hiking Trail
  { location: locations[5], feature: attributes[2] }, # Indiana Dunes: Camping
  { location: locations[6], feature: attributes[8] }, # Millennium Park: Dog-Friendly
  { location: locations[7], feature: attributes[9] }, # Willowbrook: Playground
  { location: locations[8], feature: attributes[0] }, # Morton Arboretum: Hiking
  { location: locations[9], feature: attributes[7] }, # Navy Pier: BBQ Grills
  { location: locations[10], feature: attributes[0] } # Matthiessen State Park: Hiking
])

puts "Assigned attributes to locations!"

# Create favorites
Favorite.create!([
  { user: users[0], location: locations[0] },
  { user: users[1], location: locations[1] },
  { user: users[2], location: locations[2] },
  { user: users[3], location: locations[3] },
  { user: users[4], location: locations[4] },
  { user: users[5], location: locations[5] }
])

puts "Created #{Favorite.count} favorites!"
