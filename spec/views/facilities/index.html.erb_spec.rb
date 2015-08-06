require 'rails_helper'

RSpec.describe "facilities/index", :type => :view do
  before(:each) do
    assign(:facilities, [
      Facility.create!(
        :citizen_id => 1,
        :facility_type_id => 2,
        :powered => false,
        :maintained => false,
        :utilised => 3,
        :level => 4
      ),
      Facility.create!(
        :citizen_id => 1,
        :facility_type_id => 2,
        :powered => false,
        :maintained => false,
        :utilised => 3,
        :level => 4
      )
    ])
  end

  it "renders a list of facilities" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
