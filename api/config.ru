require './application'
require './modules/users'

map '/' do
  run Corruptly::Application

  #run Proc.new {|env| [200, {"Content-Type" => "text/html"}, "infinity 0.1"] }
end

map '/users' do
  run Corruptly::Users
end
