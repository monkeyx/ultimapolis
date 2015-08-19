class StoriesController < ApplicationController
  load_and_authorize_resource
  
  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.active
  end

end
