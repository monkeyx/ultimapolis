require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  before(:each) do
    @event = assign(:event, Event.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Icon/)
  end
end
