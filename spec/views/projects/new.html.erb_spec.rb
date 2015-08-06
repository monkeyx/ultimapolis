require 'rails_helper'

RSpec.describe "projects/new", :type => :view do
  before(:each) do
    assign(:project, Project.new(
      :leader_id => 1,
      :event_id => 1,
      :began_on => 1,
      :finished_on => 1,
      :status => "MyString",
      :wages => 1
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_leader_id[name=?]", "project[leader_id]"

      assert_select "input#project_event_id[name=?]", "project[event_id]"

      assert_select "input#project_began_on[name=?]", "project[began_on]"

      assert_select "input#project_finished_on[name=?]", "project[finished_on]"

      assert_select "input#project_status[name=?]", "project[status]"

      assert_select "input#project_wages[name=?]", "project[wages]"
    end
  end
end
