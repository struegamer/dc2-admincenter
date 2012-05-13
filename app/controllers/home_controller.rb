class HomeController < ApplicationController

  def index
    @dcblist=Dcbackend.all()
    @dcbservers=[]
    @dcblist.each do |dcb|
      @dcbservers.append({"title"=>dcb[:title],"id"=>dcb[:_id]})
    end
  end
end
