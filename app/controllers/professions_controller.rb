class ProfessionsController < ApplicationController
  before_action :set_profession, only: [:show]
  load_and_authorize_resource

  # GET /professions
  # GET /professions.json
  def index
    @breadcrumbs = [["Home", root_url], ["Professions","/professions"]]
    @professions = Profession.all
  end

  # GET /professions/1
  # GET /professions/1.json
  def show
    @breadcrumbs = [["Home", root_url], ["Professions","/professions"], [@profession.to_s, "/professions/#{@profession.id}"]]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profession
      @profession = Profession.find(params[:id])
    end
end
