class Admin::InetTypesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @inettypeslist=InetType.all()
  end

  def new
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @inettype=InetType.new
  end

  def create
    @inettype=InetType.new(params[:inet_type])
    respond_to do |format|
      if @inettype.save
        format.html { redirect_to(admin_inet_types_path, :notice => "INET Type successfully created") }
        format.json { render :json => @inettype, :status => :created, :location => @inettype }
      else
        format.html { render :action => "new" }
        format.json { render :json => @inettype.errors, :status => :unprocessable_entitiy }
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @inettype=InetType.first(:id => params[:id])
  end

  def update
    @inettype=InetType.first(:id => params[:id])
    @inettype.name=params[:inet_type][:name]
    @inettype.internal_name=params[:inet_type][:internal_name]
    respond_to do |format|
      if @inettype.save
        format.html { redirect_to(admin_inet_types_path, :notice => "INET Type successfully updated" )}
        format.json { render :json => @inettype, :status => :updated, :location => @inettype }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @inettype.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @inettype=InetType.first(:id=>params[:id])
    respond_to do |format|
      if @inettype.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_inet_types_path }
      end
    end
  end
end
