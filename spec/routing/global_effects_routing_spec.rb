require "rails_helper"

RSpec.describe GlobalEffectsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/global_effects").to route_to("global_effects#index")
    end

    it "routes to #new" do
      expect(:get => "/global_effects/new").to route_to("global_effects#new")
    end

    it "routes to #show" do
      expect(:get => "/global_effects/1").to route_to("global_effects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/global_effects/1/edit").to route_to("global_effects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/global_effects").to route_to("global_effects#create")
    end

    it "routes to #update" do
      expect(:put => "/global_effects/1").to route_to("global_effects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/global_effects/1").to route_to("global_effects#destroy", :id => "1")
    end

  end
end
