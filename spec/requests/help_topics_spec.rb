require 'rails_helper'

RSpec.describe "HelpTopics", :type => :request do
  describe "GET /help_topics" do
    it "works! (now write some real specs)" do
      get help_topics_path
      expect(response).to have_http_status(200)
    end
  end
end
