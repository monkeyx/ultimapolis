class GlobalEffectsController < ApplicationController
  before_action :set_global_effect, only: [:show]
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_global_effect
      @global_effect = GlobalEffect.find(params[:id])
    end
end
