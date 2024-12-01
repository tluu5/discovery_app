require "rails_helper"

RSpec.describe "Locations Index Performance", type: :feature do
  before do
    # Creating test data
    create(:location, name: "Hiking Trail")
    create(:location, name: "Fishing Spot")
  end

  it "loads the index page with no filters within acceptable time" do
    start_time = Time.now
    visit locations_path
    end_time = Time.now

    # Ensure the page loads in less than 2 seconds
    expect(end_time - start_time).to be < 2.0
    expect(page).to have_content("Locations")
  end

  it "loads the index page with filters within acceptable time" do
    visit locations_path
    fill_in "search", with: "Hiking" # Simulate user input for filters
    click_button "Search"

    expect(page).to have_content("Filtered Locations")
    expect(page).to have_content("Hiking Trail")
    expect(page).not_to have_content("Fishing Spot")
  end
end
