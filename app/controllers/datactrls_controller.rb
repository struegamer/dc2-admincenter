class DatactrlsController < ApplicationController
  before_filter :require_login
  
  def interfaces_new
    @interfacetypes=InterfaceType.all()
    @inettypes=InetType.all()

    respond_to do |format|
      format.html { render :partial => "datactrls/interfaces_new" }
    end
  end

  def get_hw_interfaces
    backend_id=params[:backend_id]
    server_id=params[:server_id]
    dcb=Dcbackend.first(:id=>backend_id)
    dcb_conn=DcClient::MacAddrs.new(dcb)
    macaddrs=dcb_conn.list(server_id)
    @hw_names=[]
    macaddrs.each do |mac|
      @hw_names.append(mac["device_name"])
    end
    Rails::logger::debug("Backend_ID: #{backend_id} , Server_ID: #{server_id}")
    Rails::logger::debug("Macaddrs => #{macaddrs}")
    respond_to do |format|
      format.html { render :partial => "datactrls/get_hw_interfaces" }
    end
  end

end
