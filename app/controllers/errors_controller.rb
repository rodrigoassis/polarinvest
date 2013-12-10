class ErrorsController < ApplicationController
  def not_found
    render 'errors/404', layout: false
  end

  def server_error
    render 'errors/500', layout: false
  end
end