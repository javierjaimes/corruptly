class Report
  include MongoMapper::Document
  
  key :longitude, Float
  key :latitude, Float
  key :localization, String
  key :advertising_piece, String
  key :comments, String
 
end
