
class Cabinet
  include MongoMapper::Document
  
  key :manufacturer, String
  key :model, String
  key :height, Integer
  key :location, String
  
end
