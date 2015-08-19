class ExchangeTradeGoodsController < ApplicationController
  load_and_authorize_resource
  
  # GET /exchange_trade_goods/new
  def new
    @breadcrumbs = [["Home", root_url], [current_citizen,"/citizens/#{current_citizen.id}?tab=inventory"]]
    @exchange_trade_good = ExchangeTradeGood.new
    unless params[:trade_good].blank?
      @trade_good = TradeGood.find(params[:trade_good])
      @exchange_trade_good.trade_good = @trade_good
    end
    params[:buy_or_sell] ||= 'buy'
  end

  # POST /exchange_trade_goods
  # POST /exchange_trade_goods.json
  def create
    @exchange_trade_good = ExchangeTradeGood.new(exchange_trade_good_params)
    @exchange_trade_good.citizen = current_citizen 
    @exchange_trade_good.turn = Global.singleton.turn 
    @exchange_trade_good.price = @exchange_trade_good.trade_good ? @exchange_trade_good.trade_good.exchange_price : 0

    if params[:buy_or_sell] == 'sell'
      @exchange_trade_good.selling = true
    else
      params[:buy_or_sell] = 'buy'
      @exchange_trade_good.selling = false
    end
    
    respond_to do |format|
      if @exchange_trade_good.save
        format.html { redirect_to "/citizens/#{current_citizen.id}?tab=inventory", notice: 'Trade good traded.' }
        format.json { render json: @exchange_trade_good, status: :created, location: "/citizens/#{current_citizen.id}?tab=inventory" }
      else
        format.html { render :new }
        format.json { render json: @exchange_trade_good.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def exchange_trade_good_params
      params.require(:exchange_trade_good).permit(:trade_good_id, :quantity)
    end
end
