class HomeController < ApplicationController
  before_filter do |controller|
    redirect_to "/login" unless controller.send(:logged_in?)
  end

  def index
    @dcblist=Dcbackend.all()

  end
end
