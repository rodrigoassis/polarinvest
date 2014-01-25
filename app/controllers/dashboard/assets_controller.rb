class Dashboard::AssetsController < DashboardController
  before_filter :authenticate_user!, except: :autocomplete_asset_name

  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # Autocomplete action for assets
  autocomplete :asset, :name, full: true, extra_data: [:ticker], display_value: :display_name

  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_asset
  #     @asset = Asset.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def asset_params
  #     params.require(:asset).permit(:name, :type, :ticker)
  #   end
end
