class SessionsController < ApplicationController
  def new
  end 
  
  def create
    @user = User.authenticate(params[:username],params[:password])
    if @user
      session[:user_id]=@user.id.to_s
      session[:is_authenticated]=true
      session[:is_admin]=@user.is_admin
      if (@user[:is_admin] == true)
        redirect_to("/admin")
        return 
      end
      redirect_to("/")
    end
  end

  def destroy
    reset_session
    redirect_to("/")
  end
end

