class Backends::MainController < ApplicationController
  before_filter :require_login

  def index
    @dcblist=Dcbackend.all
    @dcb=Dcbackend.first(:id => params[:backend_id])
    @server_search=[
      {"name"=>"uuid","title"=>"UUID"},
      {"name"=>"serial_no","title"=>"Serial Number"},
      {"name"=>"manufacturer","title"=>"Manufacturer"},
      {"name"=>"product_name","title"=>"Product Name"},
      {"name"=>"asset_tags","title"=>"Asset Tags"},
      {"name"=>"location","title"=>"Location"}
    ]
  end
end
