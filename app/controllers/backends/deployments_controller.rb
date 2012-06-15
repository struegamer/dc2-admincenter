class Backends::DeploymentsController < ApplicationController
  def index
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Installstate.new(@dcb)
    is_list=@dcb_conn.list
    is_list_count=@dcb_conn.count
    @deployment_states={
      'Deploy Server'=>'deploy',
      'Boot from harddrive'=>'localboot'
    }
    @installstates={'islist'=>is_list,'islist_count'=>is_list_count}
    respond_to do |format|
      format.json { render :json => @installstates }
      format.html { render :partial => 'backends/deployments/list' }
    end
  end

  def update
    Rails::logger::debug(params)
    @dcb=Dcbackend.first(:id=>params[:backend_id])
    @dcb_conn=DcClient::Installstate.new(@dcb)
    entry=@dcb_conn.update(params['id'],params['status'])

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
