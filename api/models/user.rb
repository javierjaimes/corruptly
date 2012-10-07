
class User
  include MongoMapper::Document

  key :email, String
  key :password, String, :unique => true
  key :developer, Boolean, :default => false

  attr_accessible :email, :password, :developer

  validates_presence_of :email
  validates_presence_of :password

end
