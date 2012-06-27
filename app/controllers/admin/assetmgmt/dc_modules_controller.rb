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

end
