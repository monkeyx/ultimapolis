require 'rails_helper'

RSpec.describe "global_effects/new", :type => :view do
  before(:each) do
    assign(:global_effect, GlobalEffect.new(
      :event_id => 1,
      :started_on => 1,
      :expires_on => 1,
      :active => false,
      :name => "MyString",
      :description => "MyText",
      :icon => "MyString"
    ))
  end

  it "renders new global_effect form" do
    render

    assert_select "form[action=?][method=?]", global_effects_path, "post" do

      assert_select "input#global_effect_event_id[name=?]", "global_effect[event_id]"

      assert_select "input#global_effect_started_on[name=?]", "global_effect[started_on]"

      assert_select "input#global_effect_expires_on[name=?]", "global_effect[expires_on]"

      assert_select "input#global_effect_active[name=?]", "global_effect[active]"

      assert_select "input#global_effect_name[name=?]", "global_effect[name]"

      assert_select "textarea#global_effect_description[name=?]", "global_effect[description]"

      assert_select "input#global_effect_icon[name=?]", "global_effect[icon]"
    end
  end
end
