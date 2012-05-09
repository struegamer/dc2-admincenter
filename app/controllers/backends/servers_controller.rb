class Backends::ServersController < ApplicationController

  def index
    @dcb=Dcbackend.first(:id=>params[:id])
    @dcb_conn=DcClient::Servers.new(@dcb)
    @serverlist=@dcb_conn.list
    @view=params[:view]
    render :partial => "backends/servers/view_servers"
  end

  def show
    @dcb=Dcbackend.first(:id=>params[:id])
    @dcb_conn=DcClient.Servers.new(@dcb)
    @view=params[:detail]
  end
end
