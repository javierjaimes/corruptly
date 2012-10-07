class Party
  include MongoMapper::Document
  
  key :name, String
  key :logo, String
 
end
