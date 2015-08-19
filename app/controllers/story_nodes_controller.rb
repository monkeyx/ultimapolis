class StoryNodesController < ApplicationController
  before_action :set_story_node, only: [:show, :edit, :update, :flag, :unflag]
  load_and_authorize_resource

  def flag
    authorize! :flag, @story_node
    @story_node.flag!(current_user)
    render text: 'Story was flagged for moderation.', status: :ok, location: @story_node
  end

  def unflag
    authorize! :flag, @story_node
    @story_node.unflag!(current_user)
    render text: 'Story is no longer flagged for moderation by you.', status: :ok, location: @story_node
  end

  # GET /story_nodes/1
  # GET /story_nodes/1.json
  def show
    if (status = current_citizen.current_story_status(@story_node.story)) # already on this storyline
      if status.finished # finished this story
        if !params[:restart].blank? && CitizenStory.restartable_story?(current_citizen, @story_node.story) && @story_node.first?
          CitizenStory.start_story!(current_citizen, @story_node.story, true)
        else
          redirect_to stories_path, alert: 'Story has been finished. Please wait at least a day before trying again.'
          return
        end
      end
      if status.story_node.id != @story_node.id # but not at this node
        redirect_to status.story_node
        return
      end
      if @story_node.narrative.blank?
        render :edit
        return
      end
    else # not already on this storyline
      if @story_node.first? # this is the first node so lets start
        CitizenStory.start_story!(current_citizen, @story_node.story)
      else # this is not the first node so redirect
        redirect_to @story_node.story.first_node
      end
    end
  end

  # GET /story_nodes/1/edit
  def edit
  end

  # PATCH/PUT /story_nodes/1
  # PATCH/PUT /story_nodes/1.json
  def update
    @story_node.active = true
    respond_to do |format|
      if @story_node.update(story_node_params)
        format.html { redirect_to @story_node }
        format.json { render :show, status: :ok, location: @story_node }
      else
        format.html { render :edit }
        format.json { render json: @story_node.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_node
      @story_node = StoryNode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_node_params
      params.require(:story_node).permit(:story_id, :name, :narrative, :icon_css, :story_choice_id, :choice_result)
    end
end
