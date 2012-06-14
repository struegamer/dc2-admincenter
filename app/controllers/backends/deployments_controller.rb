class Backends::DeploymentsController < ApplicationController
  def index
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Installstate.new(@dcb)
    is_list=@dcb_conn.list
    is_list_count=@dcb_conn.count
    @installstates={'islist'=>is_list,'islist_count'=>is_list_count}
    respond_to do |format|
      format.json { render :json => @installstates }
      format.html { render :partial => 'backends/deployments/list' }
    end
  end
end
