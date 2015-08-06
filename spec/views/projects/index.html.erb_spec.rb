require 'rails_helper'

RSpec.describe "projects/index", :type => :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        :leader_id => 1,
        :event_id => 2,
        :began_on => 3,
        :finished_on => 4,
        :status => "Status",
        :wages => 5
      ),
      Project.create!(
        :leader_id => 1,
        :event_id => 2,
        :began_on => 3,
        :finished_on => 4,
        :status => "Status",
        :wages => 5
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
