class Backends::ServersController < ApplicationController

  def index
    @dcb=Dcbackend.first(:id=>params[:id])
    @dcb_conn=DcClient::Servers.new(@dcb)
    case params[:view]
    when "list"
      @serverlist=@dcb_conn.list
      render :partial => "backends/servers/view_servers"
    when "detail"
      server=@dcb_conn.get(params[:server_id])
      @server_detail={
        "server"=>server,
        "macaddr"=>@dcb_conn.get_mac_addr(server["_id"]),
        "ribs"=>@dcb_conn.get_ribs(server["_id"])
      }
      render :partial => "backends/servers/view_server_details"
    end
  end

  def show
    @dcb=Dcbackend.first(:id=>params[:id])
    @dcb_conn=DcClient.Servers.new(@dcb)
    @view=params[:detail]
  end
end
