class Admin::Assetmgmt::MainController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @menuname="Administration"
    @dcblist=Dcbackend.all()
    respond_to do |format|
      format.html
    end
  end
end
