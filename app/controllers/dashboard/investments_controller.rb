class Dashboard::InvestmentsController < DashboardController
  before_filter :authenticate_user!

  before_action :set_investment, only: [:show, :edit, :update, :destroy]

  # GET /investments
  # GET /investments.json
  def index
    @page_title = 'Investimentos'
    @investments = current_user.investments
  end

  # GET /investments/1
  # GET /investments/1.json
  def show
  end

  # GET /investments/new
  def new
    @investment = Investment.new
  end

  # GET /investments/1/edit
  def edit
  end

  # POST /investments
  # POST /investments.json
  def create
    investment_params_modified = Investment.translate_asset_name_into_asset_id(investment_params)
    @investment = current_user.investments.build(investment_params_modified)

    respond_to do |format|
      if @investment.save
        format.html { redirect_to dashboard_investment_path(@investment), notice: 'Investment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @investment }
      else
        format.html { render action: 'new' }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1
  # PATCH/PUT /investments/1.json
  def update
    investment_params_modified = Investment.translate_asset_name_into_asset_id(investment_params)

    respond_to do |format|
      if @investment.update(investment_params_modified)
        format.html { redirect_to dashboard_investment_path(@investment), notice: 'Investment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1
  # DELETE /investments/1.json
  def destroy
    @investment.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_investments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
      @investment = Investment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investment_params
      params.require(:investment).permit(:asset_id, :user_id, :type)
    end
end
