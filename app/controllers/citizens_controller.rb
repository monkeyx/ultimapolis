class CitizensController < ApplicationController
  before_action :set_citizen, only: [:show, :edit, :update, :inventory]
  load_and_authorize_resource

  # GET /citizens
  # GET /citizens.json
  def index
    @citizens = Citizen.all
  end

  # GET /citizens/1
  # GET /citizens/1.json
  def show
    @projects = Project.for_citizen(@citizen)
    @facilities = Facility.for_citizen(@citizen)
  end

  # GET /citizens/new
  def new
    @citizen = Citizen.new
  end

  # GET /citizens/1/edit
  def edit
  end

  # POST /citizens
  # POST /citizens.json
  def create

    @citizen = Citizen.new(citizen_params)

    if current_user
      @citizen.user = current_user  
    else
      @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      unless @user.save
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        return
      else
        sign_in(:user, @user)
      end
    end

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to @citizen, notice: 'Citizen was successfully created.' }
        format.json { render :show, status: :created, location: @citizen }
      else
        format.html { render :new }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /citizens/1
  # PATCH/PUT /citizens/1.json
  def update
    respond_to do |format|
      if @citizen.update(citizen_params)
        format.html { redirect_to @citizen, notice: 'Citizen was successfully updated.' }
        format.json { render :show, status: :ok, location: @citizen }
      else
        format.html { render :edit }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  def inventory
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_citizen
      @citizen = Citizen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def citizen_params
      params.require(:citizen).permit(:email, :password, :email_notifications, :daily_updates, :instant_updates, :credits, :home_district_id, :current_profession_id)
    end
end
