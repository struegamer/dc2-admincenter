class Backends::MainController < ApplicationController
  before_filter :require_login

  def index
    @dcblist=Dcbackend.all
    @dcb=Dcbackend.first(:id => params[:backend_id])
  end
end
