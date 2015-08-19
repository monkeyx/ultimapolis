class StoryChoicesController < ApplicationController
  before_action :set_story_choice, only: [:show]
  load_and_authorize_resource

  def show
    unless (status = current_citizen.current_story_status(@story_choice.story_node.story)) # not started this story yet
      redirect_to @story_choice.story_node.story.first_node
      return
    end
    if @story_choice.choice? # no skill check required
      name = @story_choice.name
      session[:story_choice_result] = true
      if @story_choice.success_node
        CitizenStory.next_node!(current_citizen, @story_choice.success_node)
        redirect_to @story_choice.success_node
        return
      end
    elsif @story_choice.success?(current_citizen) # skill check passed
      session[:story_choice_result] = true
      name = "#{@story_choice.name} [Success]"
      if @story_choice.threat?
        flash[:notice] = CitizenStory.overcame_threat!(current_citizen, @story_choice.story_node.story)
      elsif @story_choice.challenge?
        flash[:notice] = CitizenStory.overcame_challenge!(current_citizen, @story_choice.story_node.story)
      end
      if @story_choice.success_node
        CitizenStory.next_node!(current_citizen, @story_choice.success_node)
        redirect_to @story_choice.success_node
        return
      end
    else # skill check failed
      session[:story_choice_result] = false
      name = "#{@story_choice.name} [Failure]"
      if @story_choice.threat?
        CitizenStory.finish_story!(current_citizen, @story_choice.story_node.story)
        redirect_to stories_path, alert: "#{name} and #{@story_choice.story_node.story.name} ended."
        return
      else
        CitizenStory.next_node!(current_citizen, @story_choice.failure_node)
      end
      if @story_choice.failure_node
        redirect_to @story_choice.failure_node
        return
      end
    end
    # no existing node to continue
    node = StoryNode.create!(story: @story_choice.story_node.story, 
      name: name, 
      choice_result: session[:story_choice_result], 
      story_choice_id: @story_choice.id,
      created_by: current_user)
    CitizenStory.next_node!(current_citizen, node)

    redirect_to "/story_nodes/#{node.id}/edit"
  end

  # POST /story_choices
  # POST /story_choices.json
  def create
    @story_choice = StoryChoice.new(story_choice_params)

    unless (status = current_citizen.current_story_status(@story_choice.story_node.story)) # not started this story yet
      redirect_to @story_choice.story_node.story.first_node
      return
    end
    
    respond_to do |format|
      if @story_choice.save
        format.html { redirect_to @story_choice }
        format.json { render :show, status: :created, location: @story_choice }
      else
        format.html { render :new }
        format.json { render json: @story_choice.errors, status: :unprocessable_entity }
      end
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_choice
      @story_choice = StoryChoice.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def story_choice_params
      params.require(:story_choice).permit(:story_node_id, :choice_type, :description, :success_node_id, :failure_node_id, :skill_group)
    end
end
