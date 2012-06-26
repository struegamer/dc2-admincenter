
class Cabinet
  include MongoMapper::Document
  
  key :manufacturer, String
  key :model, String
  key :height, Integeer
  key :location, String
  
end
