require './application'
require './modules/users'
require './modules/elections'
require './modules/parties'
require './modules/reports'
require './modules/candidates'
require './modules/files'


map '/' do
  run Corruptly::Application

  #run Proc.new {|env| [200, {"Content-Type" => "text/html"}, "infinity 0.1"] }
end

map '/users' do
  run Corruptly::Users
end

map '/elections' do
  run Corruptly::Elections
end

map '/parties' do
  run Corruptly::Parties
end

map '/reports' do
  run Corruptly::Reports

  map '/file' do
    run Corruptly::Files
  end
end

<<<<<<< HEAD
map'/candidate' do
  run Corruptly::candidate
=======
map '/candidates' do
  run Corruptly::Candidates
>>>>>>> 41581b59ac38c753d49ae10fd83967b9c4fae227
end

