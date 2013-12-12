class DashboardController < ApplicationController
  before_filter :authenticate_user!

  layout 'dashboard'

  def index
    @page_title = 'PolarInvest'
  end

end
