require 'rails_helper'

RSpec.describe "DistrictEffects", :type => :request do
  describe "GET /district_effects" do
    it "works! (now write some real specs)" do
      get district_effects_path
      expect(response).to have_http_status(200)
    end
  end
end
