class Admin::Assetmgmt::DcModulesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @modulelist=DcModule.all()
  end

  def new
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @dcmodule=DcModule.new
  end

  def create
    @dcmodule=DcModule.new
    @dcmodule.name=params[:dc_module][:name]
    @dcmodule.floor=params[:dc_module][:floor]
    @dcmodule.room_no=params[:dc_module][:room_no]
    @dcmodule.racks_max=params[:dc_module][:racks_max]
    @dcmodule.rows_max=params[:dc_module][:rows_max]
    location=Location.first(:id=>params[:dc_module][:location_id])
    @dcmodule.location=location
    Rails::logger::debug(@dcmodule.location)
    respond_to do |format|
      if @dcmodule.save
        format.html { redirect_to(admin_assetmgmt_dc_modules_path, :notice =>'Module added')}
        format.json { render :json => @dcmodule, :status => :created, :location => @dcmodule }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @dcmodule.errors, :status => unprocessable_entity}
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @dcmodule=DcModule.first(:id => params[:id])
  end

  def update
    @dcmodule=DcModule.first(:id => params[:id])
    @dcmodule.name=params[:dc_module][:name]
    @dcmodule.floor=params[:dc_module][:floor]
    @dcmodule.room_no=params[:dc_module][:room_no]
    @dcmodule.racks_max=params[:dc_module][:racks_max]
    @dcmodule.rows_max=params[:dc_module][:rows_max]
    @dcmodule.location=Location.first(:id=>params[:dc_module][:location_id])
    respond_to do |format|
      if @dcmodule.save
        format.html { redirect_to(admin_assetmgmt_dc_modules_path, :notice => 'Module updated')}
        format.json { render :json => @dcmodule, :status => :updated , :location=>@dcmodule}
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @dcmodule.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @dcmodule=DcModule.first(:id => params[:id])
    respond_to do |format|
      if @dcmodule.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_assetmgmt_dc_modules_path }
      end
    end
  end

end
