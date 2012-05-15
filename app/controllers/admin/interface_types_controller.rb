class Admin::InterfaceTypesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @itypeslist=InterfaceType.all()
  end

  def new
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @itype=InterfaceType.new
  end

  def create
    @itype=InterfaceType.new(params[:interface_type])
    respond_to do |format|
      if @itype.save
        format.html { redirect_to(admin_interface_types_path, :notice => "Interface Type Successfully created") }
        format.json { render :json => @itype, :status => :created, :location => @itype }
      else
        format.html { render :action => "new" }
        format.json { render :json => @itype.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @itype=InterfaceType.first(:id => params[:id])
  end

  def update
    @itype=InterfaceType.first(:id=>params[:id])
    @itype.name=params[:interface_type][:name]
    @itype.internal_name=params[:interface_type][:internal_name]
    respond_to do |format|
      if @itype.save
        format.html { redirect_to(admin_interface_types_path, :notice => "Interface Type successfully updated") }
        format.json { render :json => @itype, :status => :updated, :location => @itype }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @itype.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @itype=InterfaceType.first(:id => params[:id])
    respond_to do |format|
      if @itype.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_interface_types_path }
      end
    end
  end
end
