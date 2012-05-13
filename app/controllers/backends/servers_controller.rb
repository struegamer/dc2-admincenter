class Backends::ServersController < ApplicationController

  def index
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Servers.new(@dcb)
    @serverlist=@dcb_conn.list
    respond_to do |format| 
      format.json { render :json => @serverlist }
    end
    #render :partial => "backends/servers/view_servers"
    #when "detail"
    #  server=@dcb_conn.get(params[:server_id])
    #  @server_detail={
    #    "server"=>server,
    #    "macaddr"=>@dcb_conn.get_mac_addr(server["_id"]),
    #    "ribs"=>@dcb_conn.get_ribs(server["_id"])
    #  }
    #  render :partial => "backends/servers/view_server_details"
    #end
  end

  def show
    @dcb=Dcbackend.first(:id=>params[:id])
    @dcb_conn=DcClient::Servers.new(@dcb)
    serverlist=@dcb_conn.list
    servercount=@dcb_conn.count
    @servers={ "serverlist" => serverlist, "servercount"=>servercount}
    respond_to do |format|
      format.json { render :json => @servers}
    end
  end
end
