class DatactrlsController < ApplicationController
  before_filter :require_login
  
  def interfaces_new
    @interfacetypes=InterfaceType.all()
    @inettypes=InetType.all()

    respond_to do |format|
      format.html { render :partial => "datactrls/interfaces_new" }
    end
  end
end
