class ProjectMembersController < ApplicationController
	before_action :set_project_member, only: [:destroy]
	load_and_authorize_resource

	def new
	end

	def create
	end

	def destroy
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_member
      @project_member = ProjectMember.find(params[:id])
    end
end
