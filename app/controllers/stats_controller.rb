class StatsController < ApplicationController
  before_filter :logged_in?

  def servers
    backend_id=params[:backend_id]
    dcb=Dcbackend.first({"_id" => backend_id })
    proxy=DcClient::Servers.new(dcb)
    @response={"count"=>proxy.count}
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
end
