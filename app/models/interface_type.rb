class InterfaceType
  include MongoMapper::Document

  key :name, String
  key :internal_name, String

end
