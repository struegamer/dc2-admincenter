class Admin::KvmsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @kvmlist=Kvm.all()
  end

  def new
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @kvm=Kvm.new
  end

  def create
    @kvm=Kvm.new(params[:kvm])
    respond_to do |format|
      if @kvm.save
        format.html { redirect_to(admin_kvms_path, :notice => "KVM Successfully created") }
        format.json {
          render :json => @kvm, :status => :created, :location => @kvm
        }
      else
        format.html { render :action => "new" }
        format.json {
          render :json => @kvm.errors, :status => :unprocessable_entity
        }
      end
    end
  end

  def edit
    @dcblist=Dcbackend.all()
    @menuname="Administration"
    @kvm=Kvm.first(:id => params[:id])
  end

  def update
    @kvm=Kvm.first(:id => params[:id])
    @kvm.kvm_type=params[:kvm][:kvm_type]
    @kvm.kvm_name=params[:kvm][:kvm_name]
    respond_to do |format|
      if @kvm.save
        format.html { redirect_to(admin_kvms_path, :notice => "KVM successfully updated") }
        format.json { render :json => @kvm, :status => :updated, :location => @kvm }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @kvm.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @kvm=Kvm.first(:id => params[:id])
    respond_to do |format|
      if @kvm.destroy
        format.json { head :no_content }
        format.html { redirect_to admin_kvms_path }
      end
    end
  end
end
