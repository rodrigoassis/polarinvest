class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show_asset]

  def index
  end

  def show_asset
    @graphic = graphic(name: home_params[:name])
  end

  def dashboard
    @graphic = graphic(user: current_user)
  end

  private

  def graphic options = {}
    LazyHighCharts::HighChart.new('graph', style: '') do |f|
      f.title(text: '')
      f.rangeSelector(enabled: false)
      f.navigator(enabled: false)
      f.legend(enabled: true, itemMarginBottom: 25, borderWidth: 0)
      f.tooltip(shared: false)

      if options[:user]
        options[:user].investments.each do |investment|
          start_date = investment.created_at || investment.asset.record.order('date asc').first.date
          info = investment.asset.values_from(start_date)
          f.series(name: investment.asset.ticker, data: info)
        end
      else
        asset = Asset.where(name: options[:name]).first
        info = asset.try(:values_from, Time.now-1.year)
        f.series(name: asset.try(:ticker), data: info)
      end

    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def home_params
    params.require(:home).permit(:name)
  end
end
