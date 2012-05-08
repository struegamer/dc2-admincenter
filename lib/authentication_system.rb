module AuthenticationSystem
  protected 
    def logged_in?
      if session[:user_id] && User.first(:id=>session[:user_id])
        true
      else
        false
      end
    end

    def is_admin?
      if session[:user_id]
        u=User.first(:id => session[:user_id])
        if u && u.is_admin
          true
        else
          false
        end
      else
        false
      end
    end
  
  def self.included(base)
    base.send :helper_method, :logged_in?, :is_admin?
  end

end

