class Backends::HostsController < ApplicationController
  
  def index
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Hosts.new(@dcb)
    hostlist=@dcb_conn.list
    hostcount=@dcb_conn.count
    @hosts={ 'hostlist' => hostlist, 'hostcount' => hostcount}
    respond_to do |format|
      format.json { render :json => @hosts }
      format.html { render :partial => 'backends/hosts/list' }
    end
  end

end
