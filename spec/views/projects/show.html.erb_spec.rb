require 'rails_helper'

RSpec.describe "projects/show", :type => :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :leader_id => 1,
      :event_id => 2,
      :began_on => 3,
      :finished_on => 4,
      :status => "Status",
      :wages => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/5/)
  end
end
