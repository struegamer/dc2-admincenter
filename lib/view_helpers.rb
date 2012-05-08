module ViewHelpers
  protected 
  def get_user(key)
    if session[:user_id]
      user=User.find_one(:_id => session[:user_id])
      if user
        if key == "name"
          "#{user[:firstname]} #{user[:lastname]}"
        else
          user[key]
        end
      end
    end
  end

  def self.included(base)
    base.send :helper_method, :get_user
  end

end

