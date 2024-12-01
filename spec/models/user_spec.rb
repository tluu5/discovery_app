require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "is invalid without a username" do
      user.username = nil
      expect(user).not_to be_valid
    end

    it "is invalid with a weak password" do
      user.password = "password"
      expect(user).not_to be_valid
    end
  end

  context "associations" do
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:favorite_locations).through(:favorites).source(:location) }
  end
end
