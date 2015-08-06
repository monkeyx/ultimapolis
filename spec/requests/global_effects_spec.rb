require 'rails_helper'

RSpec.describe "GlobalEffects", :type => :request do
  describe "GET /global_effects" do
    it "works! (now write some real specs)" do
      get global_effects_path
      expect(response).to have_http_status(200)
    end
  end
end
