
class Location
  include MongoMapper::Document

  key :title, String
  key :city, String
  key :state, String
  timestamps!

  def location_string
    "#{title}, #{city}, #{state}"
  end


end
