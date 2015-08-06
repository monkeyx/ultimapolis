require 'rails_helper'

RSpec.describe "help_topics/index", :type => :view do
  before(:each) do
    assign(:help_topics, [
      HelpTopic.create!(
        :name => "Name",
        :body => "MyText"
      ),
      HelpTopic.create!(
        :name => "Name",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of help_topics" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
