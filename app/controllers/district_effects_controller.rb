class DistrictEffectsController < ApplicationController
  before_action :set_district_effect, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /district_effects
  # GET /district_effects.json
  def index
    @district_effects = DistrictEffect.all
  end

  # GET /district_effects/1
  # GET /district_effects/1.json
  def show
  end

  # GET /district_effects/new
  def new
    @district_effect = DistrictEffect.new
  end

  # GET /district_effects/1/edit
  def edit
  end

  # POST /district_effects
  # POST /district_effects.json
  def create
    @district_effect = DistrictEffect.new(district_effect_params)

    respond_to do |format|
      if @district_effect.save
        format.html { redirect_to @district_effect, notice: 'District effect was successfully created.' }
        format.json { render :show, status: :created, location: @district_effect }
      else
        format.html { render :new }
        format.json { render json: @district_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /district_effects/1
  # PATCH/PUT /district_effects/1.json
  def update
    respond_to do |format|
      if @district_effect.update(district_effect_params)
        format.html { redirect_to @district_effect, notice: 'District effect was successfully updated.' }
        format.json { render :show, status: :ok, location: @district_effect }
      else
        format.html { render :edit }
        format.json { render json: @district_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /district_effects/1
  # DELETE /district_effects/1.json
  def destroy
    @district_effect.destroy
    respond_to do |format|
      format.html { redirect_to district_effects_url, notice: 'District effect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district_effect
      @district_effect = DistrictEffect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def district_effect_params
      params.require(:district_effect).permit(:event_id, :started_on, :expires_on, :active, :name, :description, :icon)
    end
end
