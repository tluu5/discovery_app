require "rails_helper"

RSpec.describe "Attributes Management", type: :feature do
  let!(:admin) { create(:user, admin: true) }

  before do
    login_as(admin, scope: :user) # Ensure proper scope is used for Devise helpers
  end

  describe "Creating an attribute" do
    it "allows admin to create a new attribute" do
      visit new_attribute_path
      fill_in "Attribute Name", with: "Activity"
      fill_in "Category", with: "Outdoor"
      click_button "Create Attribute"
  
      expect(page).to have_content("Attribute was successfully created.")
      expect(page).to have_content("Activity")
      expect(page).to have_content("Outdoor")
    end

    it "shows validation errors for invalid input" do
      visit new_attribute_path
      fill_in "Attribute Name", with: ""
      fill_in "Category", with: ""
      click_button "Create Attribute"
  
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Category can't be blank")
    end
  end

  describe "Deleting an attribute" do
    let!(:attribute) { create(:attribute, name: "Activity", category: "Outdoor") } # Use FactoryBot for better readability

    it "deletes an attribute" do
      visit attributes_path
  
      within("#attribute_#{attribute.id}") do
        click_link "Delete"
      end
  
      expect(page).not_to have_selector("#attribute_#{attribute.id}")
      expect(page).to have_content("Attribute was successfully destroyed.")
    end
  end
end
