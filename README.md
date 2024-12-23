# Outdoor Activity Discovery:

Discover the best outdoor locations for activities like fishing, kayaking, camping, hiking, and more in Chicago! This Ruby on Rails app helps users explore nature with personalized recommendations, detailed addresses, and descriptions for each location.

---

## Overview:

The Outdoor Activity Discovery app is designed to help users discover outdoor recreational spots in Chicago. Many city dwellers and tourists are unaware of the numerous nature-based opportunities available to them, facing challenges such as:

- Lack of centralized information about parks, campsites, and activity-friendly areas.
- Difficulty searching for specific activities like fishing or kayaking.
- Fragmented details on facilities and features.

The app addresses these issues by providing a centralized platform with curated recommendations, detailed descriptions, and search features to easily explore outdoor activities.

---

## 1-Liner:

A web platform to discover outdoor activities in Chicago, providing curated information on parks, campsites, and activity-friendly areas.

---

## Features:

- **Search and Filter**: Find locations by activity type and amenities such as restrooms, picnic areas, or hiking trails.
- **Favorites**: Save favorite spots for quick access later.
- **Admin Tools**: Admins can add, edit, or remove location entries to keep the database accurate and up-to-date. They can also moderate user reviews.

---

## Entity Relationship Diagram (ERD)

Below is the data model for the application:

![ERD][erd]

---

## Setup and Installation Instructions:

To get the project running locally, follow these steps:

### Clone the Repository:

```
bash
git clone https://github.com/username/outdoor-activity-discovery.git
cd outdoor-activity-discovery
```

---

## Install Dependencies:
Run the following command to install all required gems:

```
bundle install
```

---

## Set up the database:

```
rails db:create
rails db:migrate
rails db:seed
```

---

## Run the server:

```
rails server
```

---

## Visit the app:

Open your browser and navigate to http://localhost:3000.

---

## Contribution Guidelines
- Fork the repository and clone it locally.
- Create a new branch for your feature/fix.
- Ensure tests pass before submitting a pull request.
- Follow coding conventions: use snake_case for methods and variables.

---

## Configuration:

Database Configuration
The database uses PostgreSQL. Ensure that your local environment has PostgreSQL installed and running.

---

## Contribution Guidelines:

We welcome contributions from developers! To contribute:

1) Fork the repository on GitHub.

2) Create a feature branch:

```
git checkout -b feature/your-feature-name
```

3) Commit your changes:

```
git commit -m 'Add your message here'
```

4) Push to your branch:

```
git push origin feature/your-feature-name
```

5) Create a Pull Request on GitHub.

---

## Coding Conventions:

Follow the Ruby Style Guide.
Branch naming convention: feature/your-feature-name or bugfix/your-bugfix-name.
Write clear commit messages.

---

## Entity Relationship Diagram (ERD):

Below is the ERD for the project:

The diagram illustrates the relationships between the entities in the database, including:

Users
Locations
Attributes
Favorites
Location Attributes

---

## Troubleshooting:

If you encounter any issues, here are some common troubleshooting tips:

Database Issues: Make sure PostgreSQL is running and that you've set up the database correctly using rails db:setup.
Missing Environment Variables: Ensure that the .env file is correctly set up with all required variables.
Dependencies: If there are issues with dependencies, try running bundle install and yarn install again.

---

## Visual Aids:

**Home Page Sketch:** A search bar and filters for activities and features.
**Location Details Page:** Displays the location’s name, description, map, and user reviews.
**Favorites Page:** Lists saved locations with options to view details or remove them.
**Admin Panel:** Provides tools for managing locations and reviews.

---

## API Documentation:

The project includes a simple API for accessing locations and user data:

# Endpoints:
  GET /locations: Fetch all locations. Supports filters:
    activities: Filter by activity name.
    amenities: Filter by amenity name.
    search: Search by location name.
  POST /locations: Create a new location (admin only).

# Request Body (POST /locations):
  name: Name of the location.
  address: Address of the location.
  latitude: Latitude of the location.
  longitude: Longitude of the location.
  description: Brief description of the location.

# Authentication:
  Admin-related actions require an API key, which should be included in the Authorization header.

---

## Contact:

Created by Brian Luu - feel free to reach out if you have questions or feedback!!!


[def]: ./erd.png
[erd]: ./erd.png
