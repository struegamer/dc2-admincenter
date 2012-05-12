class HomeController < ApplicationController
  before_filter :logged_in?

  def index
    @dcblist=Dcbackend.all()
    @dcbservers=[]
    @dcblist.each do |dcb|
      proxy=DcClient::Servers.new(dcb)
      @dcbservers.append({"title"=>dcb[:title],"server_count"=>proxy.count})
    end
  end
end
