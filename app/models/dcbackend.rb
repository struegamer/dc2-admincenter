class Dcbackend
  include MongoMapper::Document

  key :title, String
  key :url, String
  key :location, String
  

end
