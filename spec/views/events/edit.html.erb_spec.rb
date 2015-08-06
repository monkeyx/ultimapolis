require 'rails_helper'

RSpec.describe "events/edit", :type => :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :event_type => "MyString",
      :started_on => 1,
      :finished_on => 1,
      :max_duration => 1,
      :success => false,
      :summary => "MyText",
      :description => "MyText",
      :winning_project_id => 1,
      :icon => "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_event_type[name=?]", "event[event_type]"

      assert_select "input#event_started_on[name=?]", "event[started_on]"

      assert_select "input#event_finished_on[name=?]", "event[finished_on]"

      assert_select "input#event_max_duration[name=?]", "event[max_duration]"

      assert_select "input#event_success[name=?]", "event[success]"

      assert_select "textarea#event_summary[name=?]", "event[summary]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "input#event_winning_project_id[name=?]", "event[winning_project_id]"

      assert_select "input#event_icon[name=?]", "event[icon]"
    end
  end
end
