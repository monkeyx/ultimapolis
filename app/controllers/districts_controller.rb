class DistrictsController < ApplicationController
  before_action :set_district, only: [:show]
  load_and_authorize_resource

  # GET /districts
  # GET /districts.json
  def index
    @breadcrumbs = [["Home", root_url], ["Districts","/districts"]]
    @districts = District.all
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
    @breadcrumbs = [["Home", root_url], ["Districts","/districts"], [@district.to_s, "/districts/#{@district.id}"]]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end
end
