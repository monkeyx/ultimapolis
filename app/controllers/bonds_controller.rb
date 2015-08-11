class BondsController < ApplicationController
  before_action :set_bond, only: [:destroy]
  load_and_authorize_resource
  
  # GET /bonds/1
  # GET /bonds/1.json
  def show
    @breadcrumbs = [["Home", root_url], [@bond.citizen,"/citizens/#{@bond.citizen.id}?tab=finances"], [@bond, "/bonds/#{@bond.id}"]]
  end

  # GET /bonds/new
  def new
    @breadcrumbs = [["Home", root_url], [current_user.citizen,"/citizens/#{current_user.citizen.id}?tab=finances"]]
    @bond = Bond.new
  end

  # POST /bonds
  # POST /bonds.json
  def create
    @bond = Bond.new(bond_params)
    @bond.citizen = current_user.citizen

    respond_to do |format|
      if @bond.save
        format.html { redirect_to "/citizens/#{@bond.citizen.id}?tab=finances", notice: 'Bond bought.' }
        format.json { render :show, status: :created, location: @bond }
      else
        format.html { render :new }
        format.json { render json: @bond.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bonds/1
  # DELETE /bonds/1.json
  def destroy
    @bond.destroy
    respond_to do |format|
      format.html { redirect_to "/citizens/#{@bond.citizen.id}?tab=finances", notice: 'Bond was sold.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bond
      @bond = Bond.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bond_params
      params.require(:bond).permit(:value)
    end
end
