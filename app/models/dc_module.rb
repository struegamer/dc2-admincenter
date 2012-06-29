
class DcModule
  include MongoMapper::Document

  key :name, String
  key :floor, String
  key :room_no, String
  key :racks_max, Integer
  key :rows_max, Integer
  belongs_to :location
  timestamps!
end
