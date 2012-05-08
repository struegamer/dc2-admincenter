# encoding: UTF-8
#
class Admin::DcbackendsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dclist=Dcbackend.all()
  end

  def new
    @dcbackend=Dcbackend.new
  end

  def create
    @dcb=Dcbackend.new(params[:dcbackend])
    respond_to do |format|
      if @dcb.save
        format.html { redirect_to(admin_dcbackends_path, :notice => "DC² Backend successfully created") }
        format.json {
          render :json => @dcb, :status => :created, :location => @dcb
        }
      else
        format.html { render :action => "new" }
        format.json {
          render :json => @dcb.errors, :status => :unprocessable_entity 
        }
      end
    end
  end

  def edit
    @dcbackend= Dcbackend.first(:id => params[:id])
  end

  def update
    @dcb = Dcbackend.first(:id => params[:id])
    @dcb.title=params[:dcbackend][:title]
    @dcb.url=params[:dcbackend][:url]
    @dcb.location=params[:dcbackend][:location]
    respond_to do |format|
      if @dcb.save
        format.html { redirect_to(admin_dcbackends_path, :notice => "DC² Backend Entry successfully updated")}
        format.json { render :json => @dcb, :status => :updated, :lcattion => @dcb }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @dcb.errors, :status => unprocessable_entity }
      end
    end
  end

  def destroy
    @dcb=Dcbackend.first(:id => params[:id])
    respond_to do |format|
      if @dcb.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_dcbackends_path }
      end
    end
  end
end
