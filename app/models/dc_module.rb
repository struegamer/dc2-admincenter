
class DcModule
  include MongoMapper::Document

  key :name, String
  key :floor, String
  key :room_no, String
  key :dimension, String
  key :racks_max, Integer
  key :rows_max, Integer
  one :location
  timestamps!
end
