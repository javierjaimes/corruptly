class Election 
  include MongoMapper::Document
  
  key :name, String
  key :corporation, String
  key :year, Integer
 
end
