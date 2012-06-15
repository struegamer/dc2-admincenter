class SessionsController < ApplicationController
  def new
  end 
  
  def create
    @user = User.authenticate(params[:username],params[:password])
    Rails::logger::debug(@user)
    if @user
      session[:user_id]=@user.id.to_s
      session[:is_authenticated]=true
      session[:is_admin]=@user.is_admin
      if (@user[:is_admin] == true)
        redirect_to("/admin")
        return 
      end
      redirect_to("/")
    else
      redirect_to('/', :flash => { :error => 'Username and/or Password are not correct.' })
    end
  end

  def destroy
    reset_session
    redirect_to("/")
  end
end

