class GlobalEffectsController < ApplicationController
  before_action :set_global_effect, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /global_effects
  # GET /global_effects.json
  def index
    @global_effects = GlobalEffect.all
  end

  # GET /global_effects/1
  # GET /global_effects/1.json
  def show
  end

  # GET /global_effects/new
  def new
    @global_effect = GlobalEffect.new
  end

  # GET /global_effects/1/edit
  def edit
  end

  # POST /global_effects
  # POST /global_effects.json
  def create
    @global_effect = GlobalEffect.new(global_effect_params)

    respond_to do |format|
      if @global_effect.save
        format.html { redirect_to @global_effect, notice: 'Global effect was successfully created.' }
        format.json { render :show, status: :created, location: @global_effect }
      else
        format.html { render :new }
        format.json { render json: @global_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /global_effects/1
  # PATCH/PUT /global_effects/1.json
  def update
    respond_to do |format|
      if @global_effect.update(global_effect_params)
        format.html { redirect_to @global_effect, notice: 'Global effect was successfully updated.' }
        format.json { render :show, status: :ok, location: @global_effect }
      else
        format.html { render :edit }
        format.json { render json: @global_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /global_effects/1
  # DELETE /global_effects/1.json
  def destroy
    @global_effect.destroy
    respond_to do |format|
      format.html { redirect_to global_effects_url, notice: 'Global effect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_global_effect
      @global_effect = GlobalEffect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def global_effect_params
      params.require(:global_effect).permit(:event_id, :started_on, :expires_on, :active, :name, :description, :icon)
    end
end
