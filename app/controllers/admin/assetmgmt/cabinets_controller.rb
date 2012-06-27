class Admin::Assetmgmt::CabinetsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @cabinetlist=Cabinet.all()
  end

  def new
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @cabinet=Cabinet.new
  end

  def create
    @cabinet=Cabinet.new(params[:cabinet])
    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to(admin_assetmgmt_cabinets_path, :notice => 'Cabinet created successfully') }
        format.json { render :json => @cabinet, :status => :created, :location => @cabinet }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @cabinet.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname='Administration'
    @cabinet=Cabinet.first(:id => params[:id])
  end

  def update
    @cabinet=Cabinet.first(:id => params[:id])
    @cabinet.manufacturer=params[:cabinet][:manufacturer]
    @cabinet.model=params[:cabinet][:model]
    @cabinet.height=params[:cabinet][:height]
    @cabinet.url = params[:cabinet][:url]
    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to(admin_assetmgmt_cabinets_path, :notice => 'Cabinet updated')}
        format.json { render :json => @cabinet, :status => :updated, :location => @cabinet}
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @cabinet.errors, :status => :unprocessable_entity}
      end
    end
  end

  def destroy
    @cabinet=Cabinet.first(:id => params[:id])
    respond_to do |format|
      if @cabinet.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_assetmgmt_cabinets_path }
      end
    end
  end
end
