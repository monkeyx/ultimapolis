class DistrictEffectsController < ApplicationController
  before_action :set_district_effect, only: [:show]
  load_and_authorize_resource

 # GET /district_effects/1
  # GET /district_effects/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district_effect
      @district_effect = DistrictEffect.find(params[:id])
    end
end
