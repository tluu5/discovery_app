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
  { email: 'admin@example.com', password: 'password', admin: true },
  { email: 'alice.brown@example.com', password: 'password', admin: false },
  { email: 'bob.jones@example.com', password: 'password', admin: false },
  { email: 'charlie.davis@example.com', password: 'password', admin: false }
])

puts "Created #{User.count} users!"

# Create attributes (categories)
attributes = Attribute.create!([
  { name: 'Hiking', category: 'Activity' },
  { name: 'Fishing', category: 'Activity' },
  { name: 'Camping', category: 'Activity' },
  { name: 'Kayaking', category: 'Activity' },
  { name: 'Picnic Area', category: 'Feature' },
  { name: 'Hiking Trail', category: 'Feature' },
  { name: 'Public Restrooms', category: 'Feature' },
  { name: 'BBQ Grills', category: 'Feature' },
  { name: 'Dog-Friendly', category: 'Feature' },
  { name: 'Playground', category: 'Feature' }
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
    longitude: -87.6233,
    description: 'A cultural landmark featuring the famous Cloud Gate and expansive green spaces.'
  },
  {
    name: 'Northerly Island',
    address: '1521 S Linn White Dr, Chicago, IL 60605',
    latitude: 41.8676,
    longitude: -87.6086,
    description: 'A man-made peninsula with hiking trails, a concert venue, and scenic views of the Chicago skyline.'
  },
  {
    name: 'Lakefront Trail',
    address: 'Lake Shore Drive, Chicago, IL',
    latitude: 41.9290,
    longitude: -87.6339,
    description: 'An 18-mile-long trail along Lake Michigan, perfect for biking, jogging, and walking.'
  },
  {
    name: 'Palos Hills Forest Preserve',
    address: '7600 W 111th St, Palos Hills, IL 60465',
    latitude: 41.6860,
    longitude: -87.8570,
    description: 'A large forest preserve with hiking, mountain biking trails, and fishing spots.'
  },
  {
    name: 'Busse Woods Forest Preserve',
    address: 'N Arlington Heights Rd & Higgins Rd, Elk Grove Village, IL 60007',
    latitude: 42.0269,
    longitude: -88.0163,
    description: 'A peaceful forest preserve with a lake for fishing and kayaking, plus bike paths.'
  },
  {
    name: 'Rock Cut State Park',
    address: '7318 Harlem Rd, Loves Park, IL 61111',
    latitude: 42.3420,
    longitude: -88.9820,
    description: 'A park offering camping, hiking, and fishing opportunities along two large lakes.'
  },
  {
    name: 'Wolf Road Prairie',
    address: '31st St & Wolf Rd, Westchester, IL 60154',
    latitude: 41.8323,
    longitude: -87.8972,
    description: 'A prairie preserve with walking trails and a variety of native plants and wildlife.'
  },
  {
    name: 'Chicago Botanic Garden',
    address: '1000 Lake Cook Rd, Glencoe, IL 60022',
    latitude: 42.1489,
    longitude: -87.7903,
    description: 'A stunning garden with miles of walking paths, themed gardens, and water features.'
  },
  {
    name: 'Matthiessen State Park',
    address: '2500 IL-178, Oglesby, IL 61348',
    latitude: 41.2920,
    longitude: -89.0027,
    description: 'A lesser-known gem near Starved Rock, featuring canyons, streams, and hiking trails.'
  },
  {
    name: 'Chain O’Lakes State Park',
    address: '8916 Wilmot Rd, Spring Grove, IL 60081',
    latitude: 42.4506,
    longitude: -88.1800,
    description: 'A park with interconnected lakes for boating, fishing, and picnicking.'
  },
  {
    name: 'Jackson Park',
    address: '6401 S Stony Island Ave, Chicago, IL 60637',
    latitude: 41.7850,
    longitude: -87.5772,
    description: 'A historic park with a Japanese garden, lagoons, and bike trails.'
  },
  {
    name: 'Illinois Beach State Park',
    address: '1 Lake Front Dr, Zion, IL 60099',
    latitude: 42.4198,
    longitude: -87.8091,
    description: 'A park along Lake Michigan with beaches, hiking trails, and campsites.'
  },
  {
    name: 'Cantigny Park',
    address: '1S151 Winfield Rd, Wheaton, IL 60189',
    latitude: 41.8529,
    longitude: -88.1522,
    description: 'A historic estate with beautifully landscaped gardens and museums.'
  },
  {
    name: 'Kankakee River State Park',
    address: '5314 W State Route 102, Bourbonnais, IL 60914',
    latitude: 41.2203,
    longitude: -87.9943,
    description: 'A park featuring the Kankakee River for fishing, canoeing, and scenic trails.'
  },
  {
    name: 'Shabbona Lake State Park',
    address: '4201 Shabbona Grove Rd, Shabbona, IL 60550',
    latitude: 41.7574,
    longitude: -88.8746,
    description: 'A peaceful park with a lake for fishing and trails for hiking.'
  },
  {
    name: 'Morton Arboretum',
    address: '4100 IL-53, Lisle, IL 60532',
    latitude: 41.8169,
    longitude: -88.0684,
    description: 'An expansive arboretum with tree-lined walking paths, gardens, and seasonal events.'
  },
  {
    name: 'Big Marsh Park',
    address: '11555 S Stony Island Ave, Chicago, IL 60633',
    latitude: 41.6839,
    longitude: -87.5846,
    description: 'An ecological park with trails, bird-watching, and a BMX bike course.'
  },
  {
    name: 'Des Plaines River Trail',
    address: 'Lake Cook Rd & Des Plaines River Rd, Deerfield, IL',
    latitude: 42.1690,
    longitude: -87.9000,
    description: 'A scenic trail running along the Des Plaines River, great for hiking and biking.'
  }
])

puts "Created #{Location.count} locations!"

# Assign features to locations
LocationAttribute.create!([
  { location: locations[0], feature: attributes[0] }, # Lincoln Park: Hiking Trail
  { location: locations[0], feature: attributes[4] }, # Lincoln Park: Picnic Area
  { location: locations[0], feature: attributes[9] }, # Lincoln Park: Playground
  { location: locations[1], feature: attributes[0] }, # Starved Rock: Hiking Trail
  { location: locations[1], feature: attributes[2] }, # Starved Rock: Camping
  { location: locations[2], feature: attributes[1] }, # Montrose Beach: Fishing
  { location: locations[2], feature: attributes[3] }, # Montrose Beach: Kayaking
  { location: locations[3], feature: attributes[4] }, # Grant Park: Picnic Area
  { location: locations[3], feature: attributes[6] }, # Grant Park: Public Restrooms
  { location: locations[4], feature: attributes[0] }, # Waterfall Glen: Hiking Trail
  { location: locations[5], feature: attributes[2] }, # Indiana Dunes: Camping
  { location: locations[5], feature: attributes[3] }  # Indiana Dunes: Kayaking
])

puts "Assigned attributes to locations!"

# Create favorites
Favorite.create!([
  { user: users[0], location: locations[0] },
  { user: users[0], location: locations[1] },
  { user: users[1], location: locations[2] },
  { user: users[1], location: locations[3] },
  { user: users[2], location: locations[4] },
  { user: users[2], location: locations[5] },
  { user: users[3], location: locations[0] },
  { user: users[4], location: locations[1] },
  { user: users[5], location: locations[5] }
])

puts "Created #{Favorite.count} favorites!"
