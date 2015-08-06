require "rails_helper"

RSpec.describe HelpTopicsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/help_topics").to route_to("help_topics#index")
    end

    it "routes to #new" do
      expect(:get => "/help_topics/new").to route_to("help_topics#new")
    end

    it "routes to #show" do
      expect(:get => "/help_topics/1").to route_to("help_topics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/help_topics/1/edit").to route_to("help_topics#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/help_topics").to route_to("help_topics#create")
    end

    it "routes to #update" do
      expect(:put => "/help_topics/1").to route_to("help_topics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/help_topics/1").to route_to("help_topics#destroy", :id => "1")
    end

  end
end
