class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
  end

  def dashboard
    @graphic = graphic current_user
  end

    private

    def graphic current_user
      LazyHighCharts::HighChart.new('graph', :style => '') do |f|
        f.title(:text => '')
        f.rangeSelector(:enabled => false)
        f.navigator(:enabled => false)
        f.legend(:enabled => true, :itemMarginBottom => 25, :borderWidth => 0)
        f.tooltip(:shared => false)

        current_user.investments.each do |investment|
          start_date = investment.created_at || investment.asset.record.order('date asc').first.date
          info = investment.asset.values_from(start_date)
          f.series(:name=>investment.asset.ticker, :data=> info)
        end
      end
    end
end
