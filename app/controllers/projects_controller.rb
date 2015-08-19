class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:new, :create]
  load_and_authorize_resource

  # GET /projects/new
  def new
    @project = Project.new(event_id: @event.id)
  end

  # GET /projects/1/edit
  def edit
    @breadcrumbs = [["Home", root_url], [current_citizen.to_s,"/citizens/#{current_citizen.id}?tab=projects"], [@project.to_s, "/projects/#{@project.id}/edit"]]
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.leader = current_citizen

    respond_to do |format|
      if @project.save
        format.html { redirect_to "/citizens/#{current_citizen.id}?tab=projects", notice: 'Project was started.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to "/citizens/#{current_citizen.id}?tab=projects", notice: 'Project was updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to "/citizens/#{current_citizen.id}?tab=projects", notice: 'Project was cancelled.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      if params[:event_type].blank?
        redirect_to "/citizens/#{current_citizen.id}?tab=projects", alert: "Invalid event"
        return false
      else
        case params[:event_type]
        when 'Crisis'
          @event = Event.current_crisis
        when 'Opportunity'
          @event = Event.current_opportunity
       end
      end
      unless @event 
        redirect_to "/citizens/#{current_citizen.id}?tab=projects", alert: "Invalid event"
        return false
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:leader_id, :event_id, :began_on, :finished_on, :status, :wages)
    end
end
