require 'rails_helper'

RSpec.describe "global_effects/index", :type => :view do
  before(:each) do
    assign(:global_effects, [
      GlobalEffect.create!(
        :event_id => 1,
        :started_on => 2,
        :expires_on => 3,
        :active => false,
        :name => "Name",
        :description => "MyText",
        :icon => "Icon"
      ),
      GlobalEffect.create!(
        :event_id => 1,
        :started_on => 2,
        :expires_on => 3,
        :active => false,
        :name => "Name",
        :description => "MyText",
        :icon => "Icon"
      )
    ])
  end

  it "renders a list of global_effects" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
  end
end
