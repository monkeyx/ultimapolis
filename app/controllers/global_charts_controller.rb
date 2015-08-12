class GlobalChartsController < ApplicationController
  GRAPHS = ['gdp', 'citizens', 'infrastructure', 'grid', 'power', 'stability', 'climate', 'liberty', 'security', 'borders', 'inflation']

  def index
    unless params[:id].blank?
      @district = District.find(params[:id])
    end
    render '/charts/index'
  end

  def infrastructure
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.infrastructure] }
  end

  def grid
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.grid] }
  end

  def power
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.power] }
  end

  def stability
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.stability] }
  end

  def climate
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.climate] }
  end

  def liberty
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.liberty] }
  end

  def security
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.security] }
  end

  def borders
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.borders] }
  end

  def inflation
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.inflation] }
  end

  def citizens
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.citizens] }
  end

  def gdp
    render json: GlobalSnapshot.order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.gdp] }
  end
end
