class Backends::MainController < ApplicationController
  before_filter :require_login

  def list
    @dcb=Dcbackend.first(:id => params[:id])
  end
end
