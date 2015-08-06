class EquipmentTypesController < ApplicationController
  before_action :set_equipment_type, only: [:show]
  load_and_authorize_resource

  # GET /equipment_types
  # GET /equipment_types.json
  def index
    @equipment_types = EquipmentType.all
  end

  # GET /equipment_types/1
  # GET /equipment_types/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_type
      @equipment_type = EquipmentType.find(params[:id])
    end
end
