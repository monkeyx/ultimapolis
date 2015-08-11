class ProjectMembersController < ApplicationController
	before_action :set_project_member, only: [:destroy]
	load_and_authorize_resource

	def create
		@project_member = ProjectMember.new(project_member_params)
		@project_member.citizen = current_user.citizen

		if @project_member.save
		  	redirect_to "/citizens/#{current_user.citizen.id}?tab=projects", notice: 'Successfully joined project.'
		else
			redirect_to "/citizens/#{current_user.citizen.id}?tab=projects", alert: "Failed to join project because #{@project_member.errors.full_messages.join("\n")}"
		end
	end

	def destroy
		@project_member.destroy
		redirect_to "/citizens/#{current_user.citizen.id}?tab=projects", notice: 'Left the project.'
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_member
      @project_member = ProjectMember.find(params[:id])
    end

    def project_member_params
      params.require(:project_member).permit(:project_id, :sabotaging)
    end
end
