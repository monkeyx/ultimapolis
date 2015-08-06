class SkillsController < ApplicationController
  before_action :set_skill, only: [:show]
  load_and_authorize_resource

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end
end
