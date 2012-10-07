class Report
  include MongoMapper::Document
  require 'joint'
  plugin Joint
  
  key :longitude, Float
  key :latitude, Float
  key :localization, String
  key :advertising_piece, String
  key :comments, String


  attachment :file
 
end
