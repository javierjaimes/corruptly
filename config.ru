require 'rack/cors'
require './application'
require './modules/users'
require './modules/elections'
require './modules/parties'
require './modules/reports'
require './modules/candidates'

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
end

map '/candidates' do
  run Corruptly::Candidates
end
