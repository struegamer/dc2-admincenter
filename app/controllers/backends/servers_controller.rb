class Backends::ServersController < ApplicationController

  def index
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Servers.new(@dcb)
    serverlist=@dcb_conn.list
    servercount=@dcb_conn.count
    @servers={ "serverlist" => serverlist, "servercount"=>servercount}
    respond_to do |format|
      format.json { render :json => @servers}
      format.html { render :partial => "backends/servers/list" }
    end
  end

  def show
    @dcblist=Dcbackend.all()
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    dcb_conn=DcClient::Servers.new(@dcb)
    server=dcb_conn.get(params[:id])
    @kvms=Kvm.all()
    Rails::logger::debug(server)
    @server_info={ "server"=> server }
    respond_to do |format|
      format.json { render :json => @server_info}
      format.html 
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @kvms=Kvm.all()
    dcb_conn=DcClient::Servers.new(@dcb)
    server=dcb_conn.get(params[:id])
    @server_info={"server"=>server}
    respond_to do |format| 
      format.html
    end
  end

  def update
    @dcblist=Dcbackend.all()
    @dcb=Dcbackend.first(:id => params["backend_id"])
    dcb_conn=DcClient::Servers.new(@dcb)
    server=params[:server]
    macs=params[:macs]
    ribs=params[:ribs]
    server={
      "_id"=>server["_id"],
      "asset_tags"=>server["asset_tags"],
      "location"=>server["location"]
    }
    macs.each do |mac|
      Rails::logger::debug("MAC: #{mac}")
    end
    ribs.each do |rib|
      Rails::logger::debug("RIBs: #{rib}")
    end
    dcb_conn.update(server,macs,ribs)
    respond_to do |format|
      format.json { render :json => @dcb }
    end
  end


end
