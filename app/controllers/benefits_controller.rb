class BenefitsController < ApplicationController
  before_action :set_benefit, only: [:show, :edit, :update, :destroy]

  # GET /benefits
  # GET /benefits.json
  def index
    @q = Benefit.includes(:department, :organisation, :product).ransack(params[:q])
    @benefits = @q.result.page params[:page]
  end

  # GET /benefits/1
  # GET /benefits/1.json
  def show
  end

  #TODO: DRY this up...
  def import
    if(params[:file])
      msg = Benefit.import(params[:file])
      if(msg.to_s.empty?)
        redirect_to benefits_path, notice: "Import successful."
      else
        redirect_to benefits_path, flash: {:error=> msg}
      end
    else
      redirect_to benefits_path, flash: {:error=> "Oops, no CVS file specified."}
    end
  end

  # GET /benefits/new
  def new
    @benefit = Benefit.new
  end

  # GET /benefits/1/edit
  def edit
  end

  # POST /benefits
  # POST /benefits.json
  def create
    @benefit = Benefit.new(benefit_params)

    respond_to do |format|
      if @benefit.save
        format.html { redirect_to @benefit, notice: 'Benefit was successfully created.' }
        format.json { render :show, status: :created, location: @benefit }
      else
        format.html { render :new }
        format.json { render json: @benefit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /benefits/1
  # PATCH/PUT /benefits/1.json
  def update
    respond_to do |format|
      if @benefit.update(benefit_params)
        format.html { redirect_to @benefit, notice: 'Benefit was successfully updated.' }
        format.json { render :show, status: :ok, location: @benefit }
      else
        format.html { render :edit }
        format.json { render json: @benefit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /benefits/1
  # DELETE /benefits/1.json
  def destroy
    @benefit.destroy
    respond_to do |format|
      format.html { redirect_to benefits_url, notice: 'Benefit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benefit
      @benefit = Benefit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benefit_params
      params.require(:benefit).permit(:department_id, :organisation_id, :product_id, :location, :original_offering, :non_cts_alternative, :cts_proposal, :type, :name, :state)
    end
end
