class User
  include MongoMapper::Document
  
  key :username, String
  key :password, String
  key :firstname, String
  key :lastname, String
  key :is_admin, Boolean

  def self.authenticate(username,password)
    u=self.first(:username => username, :password => password)
    u || nil
  end

end
