class Candidate
  include MongoMapper::Document
  
  key :name, String
  key :list_number, String
  key :position, Integer
  
end
