require 'rails_helper'

RSpec.describe "help_topics/show", :type => :view do
  before(:each) do
    @help_topic = assign(:help_topic, HelpTopic.create!(
      :name => "Name",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
