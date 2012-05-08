class ApplicationController < ActionController::Base
  include AuthenticationSystem
  include ViewHelpers

  protect_from_forgery

  def require_login
    unless logged_in? 
      flash[:error] = "You need to be logged in"
      redirect_to root_url
    end
  end

  def require_admin
    unless is_admin?
      flash[:error]="You need to be an admin"
      redirect_to root_url
    end
  end
end
