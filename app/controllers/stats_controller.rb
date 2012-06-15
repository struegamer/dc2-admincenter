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

  def hosts
    backend_id=params[:backend_id]
    dcb=Dcbackend.first({"_id" => backend_id })
    proxy=DcClient::Hosts.new(dcb)
    @response={"count" => proxy.count}
    respond_to do |format|
      format.json { render :json => @response }
    end
  end

  def kvms
    kvms=Kvm.all()
    respond_to do |format|
      format.json { render :json => kvms }
    end
  end
  
  def deployment
    dcb=Dcbackend.first({'_id' => params[:backend_id]})
    proxy=DcClient::Installstate.new(dcb)
    if params['value'] == 'localboot'
      count=proxy.count_lb
    end
    if params['value'] == 'deploy'
      count=proxy.count_deploy
    end
    respond_to do |format|
      format.json { render :json => { 'count'=>count } }
    end
  end
end
