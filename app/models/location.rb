
class Location
  include MongoMapper::Document

  key :title, String
  key :city, String
  key :state, String
  key :vendor, String
  timestamps!

end
