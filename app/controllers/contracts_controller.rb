class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]


  def import
    if(params[:file])
      msg = Contract.import(params[:file])
      if(msg.to_s.empty?)
        redirect_to contracts_path, notice: "Import successful."
      else
        redirect_to contracts_path, flash: {:error=> msg}
      end
    else
      redirect_to index_path, flash: {:error=> "Oops, no CVS file specified."}
    end
  end

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all.page params[:page]
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:reference, :source, :department_id, :supplier_name, :value, :end_date, :organisation_id, :project, :product, :value_cents, :start_date, :years, :sector, :annual_value_cents, :category, :sub_contrators, :notes, :status, :year_awarded)
    end
end