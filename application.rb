require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require "rack/oauth2/sinatra"
require 'sinatra/reloader'
require './helpers/auth'


module Corruptly
  class Application < Sinatra::Base

    #set :environment, :development
    register Rack::OAuth2::Sinatra

    disable :raise_errors
    disable :show_exceptions
    
    use Rack::Cors do |config|
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    configure :production do
      uri = URI.parse(ENV['MONGOHQ_URL'])
      MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      MongoMapper.database = uri.path.gsub(/^\//, '')
      oauth.database = Mongo::Connection.from_uri( ENV['MONGOHQ_URL'] )[ uri.path.gsub(/^\//, '') ]
    end

    configure :development do
      register Sinatra::Reloader

      MongoMapper.connection = Mongo::Connection.new()
      MongoMapper.database = 'corruptly' 

      oauth.database = Mongo::Connection.new["corruptly"]
    end

    #helpers Sinatra::Auth
    oauth.authenticator = lambda do | username, password |
      user = User.find_by_email( username )
      puts "user"
      puts user.id
      user.email if user && user.password == password
    end

    before do
      content_type :json
    end

    #oauth_required '/protected'
    #oauth_required '/protected', :scope => 'read write'

    get '/protected' do
      #puts Rack::OAuth2::Server::get_access_token query.gsub /^oauth_token=/, ''
      #puts "Y el token"
      #if oauth.authenticated?
      #'Show me!!!'
      #else
      #  'Not authtenticated'
      #end
      "Hola mundo"

    end

    #error 401 do
    #  return [401, { "Content-Type"=>"text/plain" }, [error && error.message || ""]]
    #end

  end
end
