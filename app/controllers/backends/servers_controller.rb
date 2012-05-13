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
    Rails::logger::debug("server_id #{params['server[_id]']}")
    Rails::logger::debug("Server #{params[:server]}")
    Rails::logger::debug("MACs #{params[:macs]}")
    server={
      "_id"=>params[:server[:_id]],
      "asset_tags"=>params[:server["asset_tags"]],
      "location"=>params[:server["location"]]
    }
    dcb_conn.update(server)
    respond_to do |format|
      format.json { render :json => @dcb }
    end
  end


end
