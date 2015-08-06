require "rails_helper"

RSpec.describe DistrictEffectsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/district_effects").to route_to("district_effects#index")
    end

    it "routes to #new" do
      expect(:get => "/district_effects/new").to route_to("district_effects#new")
    end

    it "routes to #show" do
      expect(:get => "/district_effects/1").to route_to("district_effects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/district_effects/1/edit").to route_to("district_effects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/district_effects").to route_to("district_effects#create")
    end

    it "routes to #update" do
      expect(:put => "/district_effects/1").to route_to("district_effects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/district_effects/1").to route_to("district_effects#destroy", :id => "1")
    end

  end
end
