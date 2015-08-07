class TradeGoodsController < ApplicationController
  before_action :set_trade_good, only: [:show]
  load_and_authorize_resource

  # GET /trade_goods
  # GET /trade_goods.json
  def index
    @breadcrumbs = [["Home", root_url], ["Trade Goods","/trade_goods"]]
    @trade_goods = TradeGood.all
  end

  # GET /trade_goods/1
  # GET /trade_goods/1.json
  def show
    @breadcrumbs = [["Home", root_url], ["Trade Goods","/trade_goods"], [@trade_good.to_s, "/trade_goods/#{@trade_good.id}"]]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_good
      @trade_good = TradeGood.find(params[:id])
    end
end
