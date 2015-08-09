class LoansController < ApplicationController
  before_action :set_loan, only: [:destroy]

  # GET /loans/1
  # GET /loans/1.json
  def show
    @breadcrumbs = [["Home", root_url], [@loan.citizen,"/citizens/#{@loan.citizen.id}?tab=finances"], [@bond, "/loans/#{@loan.id}"]]
  end

  # GET /loans/new
  def new
    @breadcrumbs = [["Home", root_url], [current_user.citizen,"/citizens/#{current_user.citizen.id}?tab=finances"]]
    @loan = Loan.new(value: current_user.citizen.maximum_loan)
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    @loan.citizen = current_user.citizen

    respond_to do |format|
      if @loan.save
        format.html { redirect_to "/citizens/#{@loan.citizen.id}?tab=finances", notice: 'Loan taken.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to "/citizens/#{@loan.citizen.id}?tab=finances", notice: 'Loan was repaid.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:value)
    end
end
