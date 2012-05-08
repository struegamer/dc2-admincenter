class BackendsController < ApplicationController
  include DcClient
  before_filter :logged_in?

  def show
    @dcblist = Dcbackend.all
    @dcb = Dcbackend.first(:id => params[:id])
  end

  def servers
  end
end
