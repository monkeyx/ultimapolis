require 'rails_helper'

RSpec.describe "help_topics/edit", :type => :view do
  before(:each) do
    @help_topic = assign(:help_topic, HelpTopic.create!(
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit help_topic form" do
    render

    assert_select "form[action=?][method=?]", help_topic_path(@help_topic), "post" do

      assert_select "input#help_topic_name[name=?]", "help_topic[name]"

      assert_select "textarea#help_topic_body[name=?]", "help_topic[body]"
    end
  end
end
