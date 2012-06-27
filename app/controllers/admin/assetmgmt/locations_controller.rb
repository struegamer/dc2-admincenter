class Admin::Assetmgmt::LocationsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @locationlist=Location.all()
  end
  def new
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @location=Location.new
  end

  def create
    @location=Location.new(params[:location])
    respond_to do |format|
      if @location.save
        format.html { redirect_to(admin_assetmgmt_locations_path, :notice => 'Location added')}
        format.json { render :json => @location, :status => :created, :location => @location}
      else
        format.html { render :action => 'new' }
        format.json { render :json => @location.errors, :status=>:unprocessable_entity}
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @location=Location.first(:id => params[:id])
  end

  def update
    @location=Location.first(:id => params[:id])
    @location.title=params[:location][:title]
    @location.city=params[:location][:city]
    @location.state=params[:location][:state]
    respond_to do |format|
      if @location.save
        format.html { redirect_to(admin_assetmgmt_locations_path,:notice=>'Location updated')}
        format.json { render :json => @location, :status => :updated, :location =>@location}
      else
        format.html { render :action => 'edit'}
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @location=Location.first(:id => params[:id])
    respond_to do |format|
      if @location.destroy
        format.html { redirect_to admin_assetmgmt_locations_path }
        format.json { head :no_content }
      end
    end
  end
end
