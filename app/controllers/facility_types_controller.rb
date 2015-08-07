class FacilityTypesController < ApplicationController
  before_action :set_facility_type, only: [:show]
  load_and_authorize_resource

  # GET /facility_types
  # GET /facility_types.json
  def index
    @facility_types = FacilityType.all
    unless params[:filter_district].blank?
      @filter_district = District.where(id: params[:filter_district]).first
      @facility_types = @facility_types.for_district(@filter_district) if @filter_district
    end
  end

  # GET /facility_types/1
  # GET /facility_types/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_type
      @facility_type = FacilityType.find(params[:id])
    end
end
