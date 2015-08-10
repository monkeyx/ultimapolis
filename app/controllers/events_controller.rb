class EventsController < ApplicationController
  before_action :set_event, only: [:show]
  load_and_authorize_resource

  # GET /events/1
  # GET /events/1.json
  def show
    if current_user && current_user.citizen
      @breadcrumbs = [["Home", root_url], [current_user.citizen.to_s,"/citizens/#{current_user.citizen.id}?tab=projects"], [@event.to_s, "/events/#{@event.id}"]]
    end
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
