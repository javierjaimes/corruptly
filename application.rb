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


    configure :production do
      MongoMapper.connection = Mongo::Connection.new( ENV['MONGOHQ_URL'] )
      oauth.database = Mongo::Connection.new( ENV['MONGOHQ_URL'] )["corruptly"]
    end

    configure :development do
      register Sinatra::Reloader

      MongoMapper.connection = Mongo::Connection.new()
      oauth.database = Mongo::Connection.new["corruptly"]
    end

    MongoMapper.database = 'corruptly' 

    #helpers Sinatra::Auth
    oauth.authenticator = lambda do | username, password |
      user = User.find_by_email( username )
      puts "user"
      puts user.id
      user.email if user && user.password == password
    end

    before do
      #protected!
      content_type :json
      #@current_user = User.find_by_email(oauth.identity) if oauth.authenticated?
      #@get = CGI::parse(request.query_string).to_json

      #load the query string
      query = request.query_string
      #unless !/^oauth_token/.match( query ).nil?
        ##throw(:halt, [401, "Unanthorized"]) 
      #end

      unless query.match( 'oauth_token=' )
        puts 'si'
        throw( :halt, [ 401, "Unauthorized" ])
      end

      #oauth_token = 
      token =  Rack::OAuth2::Server::get_access_token query.gsub /^oauth_token=/, ''
      puts token
      #puts token.identity
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
