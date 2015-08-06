class ProfessionsController < ApplicationController
  before_action :set_profession, only: [:show]
  load_and_authorize_resource

  # GET /professions
  # GET /professions.json
  def index
    @professions = Profession.all
  end

  # GET /professions/1
  # GET /professions/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profession
      @profession = Profession.find(params[:id])
    end
end
