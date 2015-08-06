require 'rails_helper'

RSpec.describe "global_effects/show", :type => :view do
  before(:each) do
    @global_effect = assign(:global_effect, GlobalEffect.create!(
      :event_id => 1,
      :started_on => 2,
      :expires_on => 3,
      :active => false,
      :name => "Name",
      :description => "MyText",
      :icon => "Icon"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Icon/)
  end
end
