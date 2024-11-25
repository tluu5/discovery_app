# Clear existing data
User.destroy_all
Location.destroy_all
Attribute.destroy_all
LocationAttribute.destroy_all
Favorite.destroy_all

puts "All data cleared!"

# Create users
users = User.create!([
  { email: 'john.doe@example.com', password: 'password', admin: false },
  { email: 'jane.smith@example.com', password: 'password', admin: false },
  { email: 'admin@example.com', password: 'password', admin: true }
])

puts "Created #{User.count} users!"

# Create attributes (categories)
attributes = Attribute.create!([
  { name: 'Hiking', category: 'Activity' },
  { name: 'Fishing', category: 'Activity' },
  { name: 'Camping', category: 'Activity' },
  { name: 'Kayaking', category: 'Activity' },
  { name: 'Picnic Area', category: 'Feature' },
  { name: 'Hiking Trail', category: 'Feature'},
  { name: 'Public Restrooms', category: 'Feature'}
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
  }
])

puts "Created #{Location.count} locations!"

# Assign features to locations
LocationAttribute.create!([
  { location: locations[0], feature: attributes[0] }, # Lincoln Park has Hiking Trail
  { location: locations[0], feature: attributes[4] }, # Lincoln Park has Picnic Area
  { location: locations[1], feature: attributes[0] }, # Starved Rock has Hiking Trail
  { location: locations[1], feature: attributes[2] }, # Starved Rock has Camping Ground
  { location: locations[2], feature: attributes[1] }, # Montrose Beach has Fishing Spot
  { location: locations[2], feature: attributes[3] }  # Montrose Beach has Kayaking Area
])

puts "Assigned attributes to locations!"

# Create favorites
Favorite.create!([
  { user: users[0], location: locations[0] }, # John likes Lincoln Park
  { user: users[0], location: locations[1] }, # John likes Starved Rock
  { user: users[1], location: locations[2] }, # Jane likes Montrose Beach
  { user: users[1], location: locations[0] }  # Jane likes Lincoln Park
])

puts "Created #{Favorite.count} favorites!"
