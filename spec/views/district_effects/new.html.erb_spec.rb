require 'rails_helper'

RSpec.describe "district_effects/new", :type => :view do
  before(:each) do
    assign(:district_effect, DistrictEffect.new(
      :event_id => 1,
      :started_on => 1,
      :expires_on => 1,
      :active => false,
      :name => "MyString",
      :description => "MyText",
      :icon => "MyString"
    ))
  end

  it "renders new district_effect form" do
    render

    assert_select "form[action=?][method=?]", district_effects_path, "post" do

      assert_select "input#district_effect_event_id[name=?]", "district_effect[event_id]"

      assert_select "input#district_effect_started_on[name=?]", "district_effect[started_on]"

      assert_select "input#district_effect_expires_on[name=?]", "district_effect[expires_on]"

      assert_select "input#district_effect_active[name=?]", "district_effect[active]"

      assert_select "input#district_effect_name[name=?]", "district_effect[name]"

      assert_select "textarea#district_effect_description[name=?]", "district_effect[description]"

      assert_select "input#district_effect_icon[name=?]", "district_effect[icon]"
    end
  end
end
