
class User
  include MongoMapper::Document

  key :email, String
  key :password, String
  key :developer, Boolean

  attr_accessible :email, :password

end
