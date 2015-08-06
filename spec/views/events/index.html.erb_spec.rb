require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "Name",
        :event_type => "Event Type",
        :started_on => 1,
        :finished_on => 2,
        :max_duration => 3,
        :success => false,
        :summary => "MyText",
        :description => "MyText",
        :winning_project_id => 4,
        :icon => "Icon"
      ),
      Event.create!(
        :name => "Name",
        :event_type => "Event Type",
        :started_on => 1,
        :finished_on => 2,
        :max_duration => 3,
        :success => false,
        :summary => "MyText",
        :description => "MyText",
        :winning_project_id => 4,
        :icon => "Icon"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Event Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
  end
end
