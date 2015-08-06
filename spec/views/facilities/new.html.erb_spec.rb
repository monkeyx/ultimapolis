require 'rails_helper'

RSpec.describe "facilities/new", :type => :view do
  before(:each) do
    assign(:facility, Facility.new(
      :citizen_id => 1,
      :facility_type_id => 1,
      :powered => false,
      :maintained => false,
      :utilised => 1,
      :level => 1
    ))
  end

  it "renders new facility form" do
    render

    assert_select "form[action=?][method=?]", facilities_path, "post" do

      assert_select "input#facility_citizen_id[name=?]", "facility[citizen_id]"

      assert_select "input#facility_facility_type_id[name=?]", "facility[facility_type_id]"

      assert_select "input#facility_powered[name=?]", "facility[powered]"

      assert_select "input#facility_maintained[name=?]", "facility[maintained]"

      assert_select "input#facility_utilised[name=?]", "facility[utilised]"

      assert_select "input#facility_level[name=?]", "facility[level]"
    end
  end
end
