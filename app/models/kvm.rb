class Kvm
  include MongoMapper::Document

  key :kvm_type, String
  key :kvm_name, String

end
