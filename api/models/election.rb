class Election 
  include MongoMapper::Document
  
  key :name, String
  key :corporation, String
  key :year, Integer
  validates_presence_of :name
  validates_presence_of :corporation
  validates_numericality_of :year
 
end
