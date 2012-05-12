class HomeController < ApplicationController
  before_filter :logged_in?

  def index
    @dcblist=Dcbackend.all()
  end
end
