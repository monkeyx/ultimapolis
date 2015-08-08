class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    @breadcrumbs = [["Home", root_url], [@facility.citizen,"/citizens/#{@facility.citizen.id}?tab=facilities"], [@facility, "/facilities/#{@facility.id}"]]
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
    @facility_types = (current_user && current_user.citizen ? FacilityType.buildable_and_affordable(current_user.citizen.credits) : [])
    if @facility_types.empty?
      respond_to do |format|
        format.html { redirect_to current_user.citizen , alert: 'No suitable facilities can be built.' }
      end
    end
  end

  # GET /facilities/1/edit
  def edit
    @breadcrumbs = [["Home", root_url], [@facility.citizen,"/citizens/#{@facility.citizen.id}"], [@facility, "/facilities/#{@facility.id}"]]
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(facility_params)
    @facility.citizen = current_user.citizen

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully built.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    levels = params[:levels].blank? ? nil : params[:levels].to_i
    @facility.level += levels
    respond_to do |format|
      if @facility.update(facility_params)
        if levels > 0
          notice = 'Facility was successfully upgraded.'
        else
          notice = 'Facility was successfully managed.'
        end
        format.html { redirect_to @facility, notice: notice }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to @facility.citizen, notice: 'Facility was successfully demolished.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:facility_type_id, :producing_trade_good_id, :producing_equipment_type_id)
    end
end
