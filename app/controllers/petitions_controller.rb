class PetitionsController < ApplicationController
  before_action :set_petition, only: [:show, :edit, :update, :destroy, :vote_for, :vote_against]

  # GET /petitions
  # GET /petitions.json
  def index
    @breadcrumbs = [["Home", root_url], ["Petitions","/petitions"]]
    @open_petitions = Petition.open
    @accepted_petitions = Petition.accepted.order('updated_at DESC')
  end

  # GET /petitions/1
  # GET /petitions/1.json
  def show
    @breadcrumbs = [["Home", root_url], ["Petitions","/petitions"], [@petition, "/petitions/#{@petition.id}"]]
    @commentable = @petition
  end

  # GET /petitions/new
  def new
    @breadcrumbs = [["Home", root_url], ["Petitions","/petitions"]]
    @petition = Petition.new
  end

  # GET /petitions/1/edit
  def edit
    @breadcrumbs = [["Home", root_url], ["Petitions","/petitions"], [@petition, "/petitions/#{@petition.id}"]]
  end

  # POST /petitions
  # POST /petitions.json
  def create
    @petition = Petition.new(petition_params)
    @petition.citizen = current_user.citizen

    respond_to do |format|
      if @petition.save
        current_user.likes @petition
        format.html { redirect_to @petition, notice: 'Petition was submitted.' }
        format.json { render :show, status: :created, location: @petition }
      else
        format.html { render :new }
        format.json { render json: @petition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /petitions/1
  # PATCH/PUT /petitions/1.json
  def update
    respond_to do |format|
      if @petition.update(petition_params)
        format.html { redirect_to @petition, notice: 'Petition was updated.' }
        format.json { render :show, status: :ok, location: @petition }
      else
        format.html { render :edit }
        format.json { render json: @petition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /petitions/1
  # DELETE /petitions/1.json
  def destroy
    @petition.destroy
    respond_to do |format|
      format.html { redirect_to petitions_url, notice: 'Petition was cancelled.' }
      format.json { head :no_content }
    end
  end

  def vote_for
    @petition.liked_by current_user
    respond_to do |format|
      format.html { redirect_to @petition, notice: 'Voted for petition' }
      format.json { head :no_content }
    end
  end

  def vote_against
    @petition.disliked_by current_user
    respond_to do |format|
      format.html { redirect_to @petition, notice: 'Voted against petition' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_petition
      @petition = Petition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def petition_params
      params.require(:petition).permit(:name, :summary)
    end
end
