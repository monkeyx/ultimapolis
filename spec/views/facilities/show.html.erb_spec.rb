require 'rails_helper'

RSpec.describe "facilities/show", :type => :view do
  before(:each) do
    @facility = assign(:facility, Facility.create!(
      :citizen_id => 1,
      :facility_type_id => 2,
      :powered => false,
      :maintained => false,
      :utilised => 3,
      :level => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
