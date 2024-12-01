require 'rails_helper'

RSpec.describe 'Locations Management', type: :feature do
  before do
    # Create an admin user and log in
    User.create!(
      email: 'admin@example.com',
      username: 'AdminUser',
      password: 'Password1!',
      admin: true
    )
    visit new_user_session_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'Password1!'
    click_button 'Log in'
  end

  it 'navigates to the admin locations page' do
    visit root_path
    click_link 'Admin Locations'
    expect(page).to have_content('Admin: Locations')
  end  

  it 'has a link to add a new location' do
    visit admin_locations_path
    expect(page).to have_link('Add New Location', href: new_admin_location_path)
  end  

  it 'creates a new location' do
    visit new_admin_location_path
    fill_in 'Location Name', with: 'Test Location'
    fill_in 'Address', with: '123 Test St, Test City'
    fill_in 'Latitude', with: '40.7128'
    fill_in 'Longitude', with: '-74.0060'
    fill_in 'Description', with: 'A great place to visit.'
    click_button 'Create Location'
    expect(page).to have_content('Location was successfully created.')
    expect(page).to have_content('Test Location')
  end  

  it 'edits an existing location' do
    location = Location.create!(name: 'Old Name', address: 'Old Address', latitude: 40.0, longitude: -75.0)
    visit edit_admin_location_path(location)
    fill_in 'Location Name', with: 'Updated Name'
    fill_in 'Address', with: 'Updated Address'
    fill_in 'Latitude', with: '40.7128'
    fill_in 'Longitude', with: '-74.0060'
    fill_in 'Description', with: 'A beautiful place.'
    click_button 'Update Location'
    expect(page).to have_content('Location was successfully updated.')
    expect(page).to have_content('Updated Name')
  end

  it 'displays the correct buttons and forms on the index page' do
    Location.create!(name: 'Sample Location', address: '123 Street', latitude: 40.7128, longitude: -74.0060)
    visit admin_locations_path
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
  end

  it 'shows errors when creating a location with invalid data' do
    visit new_admin_location_path
    click_button 'Create Location' # Submit the form without filling fields
  
    # Check for validation error messages with consistent formatting
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("Latitude can't be blank")
    expect(page).to have_content("Longitude can't be blank")
  end   

  it 'deletes a location successfully' do
    location = Location.create!(name: 'Sample Location', address: '123 Street', latitude: 40.7128, longitude: -74.0060)
  
    visit admin_locations_path
    click_link 'Delete', href: admin_location_path(location)
  
    # Check that the correct success message is displayed
    expect(page).to have_content('Location deleted successfully.')
    expect(page).not_to have_content('Sample Location')
  end  
end
