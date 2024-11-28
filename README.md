Outdoor Activity Discovery

Discover the best outdoor locations for activities like fishing, kayaking, camping, hiking, and more in Chicago! This Ruby on Rails app helps users explore nature with personalized recommendations, detailed addresses, and descriptions for each location.

Overview

The Outdoor Activity Discovery app is designed to help users discover outdoor recreational spots in Chicago. Many city dwellers and tourists are unaware of the numerous nature-based opportunities available to them, facing challenges such as:

Lack of centralized information about parks, campsites, and activity-friendly areas.

Difficulty searching for specific activities like fishing or kayaking.

Fragmented details on facilities and features.

The app addresses these issues by providing a centralized platform with curated recommendations, detailed descriptions, and search features to easily explore outdoor activities.

1-Liner

A web platform to discover outdoor activities in Chicago, providing curated information on parks, campsites, and activity-friendly areas.

Features

Search and Filter: Find locations by activity type and amenities such as restrooms, picnic areas, or hiking trails.

Interactive Map: View outdoor spots on a dynamic map, with clickable pins to discover locations nearby.

Favorites: Save favorite spots for quick access later.

User Reviews: Read and leave reviews on different outdoor spots.

Admin Tools: Admins can add, edit, or remove location entries to keep the database accurate and up-to-date. They can also moderate user reviews.

User Stories

Users:

Find outdoor spots in Chicago based on preferred activities.

Filter locations by features and facilities (e.g., restrooms, picnic areas).

Save favorite spots and view them later.

Read and leave reviews for locations.

Discover nearby spots using a map view.

Admins:

Manage location details to ensure accuracy.

Moderate user reviews.

Domain Model

Entities:

User: id, admin, email, username, created_at, updated_at

Location: id, name, address, latitude, longitude, description, created_at, updated_at

Attribute: id, name, category, created_at, updated_at

Favorite: id, location_id, user_id, created_at, updated_at

Location_Attribute: id, location_id, feature_id, created_at, updated_at

Associations:

A User can have many Favorites.

A Location can belong to many Favorites.

A Location can have many Attributes through Location_Attribute.

Setup and Installation Instructions

To get the project running locally, follow these steps:

Clone the repository:

git clone https://github.com/username/outdoor-activity-discovery.git
cd outdoor-activity-discovery

Install dependencies:

bundle install
yarn install

Set up the database:

rails db:create
rails db:migrate
rails db:seed

Run the server:

rails server

Visit the app:
Open your browser and navigate to http://localhost:3000.

Configuration

Environment Variables

Create a .env file in the root directory to set up environment variables like the Google Maps API key:

GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here

Database Configuration

The database uses PostgreSQL. Ensure that your local environment has PostgreSQL installed and running.

Contribution Guidelines

We welcome contributions from developers! To contribute:

Fork the repository on GitHub.

Create a feature branch:

git checkout -b feature/your-feature-name

Commit your changes:

git commit -m 'Add your message here'

Push to your branch:

git push origin feature/your-feature-name

Create a Pull Request on GitHub.

Coding Conventions

Follow the Ruby Style Guide.

Branch naming convention: feature/your-feature-name or bugfix/your-bugfix-name.

Write clear commit messages.

Troubleshooting

If you encounter any issues, here are some common troubleshooting tips:

Database Issues: Make sure PostgreSQL is running and that you've set up the database correctly using rails db:setup.

Missing Environment Variables: Ensure that the .env file is correctly set up with all required variables.

Dependencies: If there are issues with dependencies, try running bundle install and yarn install again.

Visual Aids

Home Page: A search bar and filters for activities and features.

Location Details Page: Displays the location’s name, description, map, and user reviews.

Favorites Page: Lists saved locations with options to view details or remove them.

Admin Panel: Provides tools for managing locations and reviews.

API Documentation

The project includes a simple API for accessing locations and user data:

GET /api/locations: Retrieve a list of all locations.

Response: JSON object containing location details.

POST /api/locations: Create a new location (admin only).

Request Body: name, address, latitude, longitude, description.

Authentication: Use an API key for admin-related actions. Include the key in the Authorization header.

Contact

Created by Brian Luu - feel free to reach out if you have questions or feedback!
