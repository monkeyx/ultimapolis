require 'rails_helper'

RSpec.describe "help_topics/new", :type => :view do
  before(:each) do
    assign(:help_topic, HelpTopic.new(
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new help_topic form" do
    render

    assert_select "form[action=?][method=?]", help_topics_path, "post" do

      assert_select "input#help_topic_name[name=?]", "help_topic[name]"

      assert_select "textarea#help_topic_body[name=?]", "help_topic[body]"
    end
  end
end
