class TradeGoodsController < ApplicationController
  before_action :set_trade_good, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /trade_goods
  # GET /trade_goods.json
  def index
    @trade_goods = TradeGood.all
  end

  # GET /trade_goods/1
  # GET /trade_goods/1.json
  def show
  end

  # GET /trade_goods/new
  def new
    @trade_good = TradeGood.new
  end

  # GET /trade_goods/1/edit
  def edit
  end

  # POST /trade_goods
  # POST /trade_goods.json
  def create
    @trade_good = TradeGood.new(trade_good_params)

    respond_to do |format|
      if @trade_good.save
        format.html { redirect_to @trade_good, notice: 'Trade good was successfully created.' }
        format.json { render :show, status: :created, location: @trade_good }
      else
        format.html { render :new }
        format.json { render json: @trade_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_goods/1
  # PATCH/PUT /trade_goods/1.json
  def update
    respond_to do |format|
      if @trade_good.update(trade_good_params)
        format.html { redirect_to @trade_good, notice: 'Trade good was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_good }
      else
        format.html { render :edit }
        format.json { render json: @trade_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_goods/1
  # DELETE /trade_goods/1.json
  def destroy
    @trade_good.destroy
    respond_to do |format|
      format.html { redirect_to trade_goods_url, notice: 'Trade good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_good
      @trade_good = TradeGood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_good_params
      params.require(:trade_good).permit(:name, :facility_type_id, :exchange_price, :total, :produced_last_turn, :for_sale)
    end
end
