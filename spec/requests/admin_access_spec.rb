require "rails_helper"

RSpec.describe "Admin Access", type: :request do
  let(:user) { create(:user, admin: false) }
  let!(:admin) { create(:user, :admin) }

  before do
    sign_in user
  end  

  describe "GET /admin/locations" do
    context "when logged in as an admin" do
      before { sign_in admin }

      it "allows access to admin locations page" do
        get admin_locations_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
