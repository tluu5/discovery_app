# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  description :string
#  latitude    :float            not null
#  longitude   :float            not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_locations_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      location = build(:location)
      expect(location).to be_valid
    end

    it "is invalid without a name" do
      location = build(:location, name: nil)
      expect(location).not_to be_valid
    end

    it "is invalid with out-of-bounds latitude" do
      location = build(:location, latitude: 200)
      expect(location).not_to be_valid
    end

    it "is invalid without an address" do
      location = build(:location, address: nil)
      expect(location).not_to be_valid
    end
  end

  describe "associations" do
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:location_attributes).dependent(:destroy) }
    it { should have_many(:features).through(:location_attributes) }
  end
end
