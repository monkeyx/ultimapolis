class ExchangeEquipmentsController < ApplicationController
  load_and_authorize_resource
  
  # GET /exchange_equipments/new
  def new
    @breadcrumbs = [["Home", root_url], [current_user.citizen,"/citizens/#{current_user.citizen.id}?tab=inventory"]]
    @exchange_equipment = ExchangeEquipment.new
    unless params[:equipment_type].blank?
      @equipment_type = EquipmentType.find(params[:equipment_type])
      @exchange_equipment.equipment_type = @equipment_type
    end
    params[:buy_or_sell] ||= 'buy'
  end

  # POST /exchange_equipments
  # POST /exchange_equipments.json
  def create
    @exchange_equipment = ExchangeEquipment.new(exchange_equipment_params)
    @exchange_equipment.citizen = current_user.citizen 
    @exchange_equipment.turn = Global.singleton.turn 
    @exchange_equipment.price = @exchange_equipment.equipment_type ? @exchange_equipment.equipment_type.exchange_price : 0

    if params[:buy_or_sell] == 'sell'
      @exchange_equipment.selling = true
    else
      params[:buy_or_sell] = 'buy'
      @exchange_equipment.selling = false
    end

    respond_to do |format|
      if @exchange_equipment.save
        format.html { redirect_to "/citizens/#{current_user.citizen.id}?tab=inventory", notice: 'Equipment traded.' }
        format.json { render json: @exchange_equipment, status: :created, location: "/citizens/#{current_user.citizen.id}?tab=inventory" }
      else
        format.html { render :new }
        format.json { render json: @exchange_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def exchange_equipment_params
      params.require(:exchange_equipment).permit(:equipment_type_id, :quantity)
    end
end
