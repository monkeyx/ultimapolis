class DistrictChartsController < ApplicationController
  GRAPHS = ['total_land', 'free_land', 'transport_capacity','civilians','automatons','unrest','health','policing','social',
            'environment','housing','education','community','creativity','aesthetics','crime','corruption']

  before_action :set_district

  def total_land
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.total_land] }
  end

  def free_land
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.free_land] }
  end

  def transport_capacity
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.transport_capacity] }
  end

  def civilians
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.civilians] }
  end

  def automatons
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.automatons] }
  end

  def unrest
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.unrest] }
  end

  def health
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.health] }
  end

  def policing
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.policing] }
  end

  def social
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.social] }
  end

  def environment
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.environment] }
  end

  def housing
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.housing] }
  end

  def education
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.education] }
  end

  def community
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.community] }
  end

  def creativity
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.creativity] }
  end

  def aesthetics
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.aesthetics] }
  end

  def crime
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.crime] }
  end

  def corruption
    render json: DistrictSnapshot.for_district(@district).order('turn DESC').limit(60).reverse.map{|s| [format_turn(s.turn), s.corruption] }
  end

private
  def set_district
    @district = District.find(params[:id])
  end

end
