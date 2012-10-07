require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require "rack/oauth2/sinatra"
require 'sinatra/reloader'
require './helpers/auth'
require './models/election'

MongoMapper.connection = Mongo::Connection.new()
MongoMapper.database = 'corruptly' 

module Corruptly
  class Application < Sinatra::Base

    #set :environment, :development
    disable :raise_errors
    disable :show_exceptions

    configure :development do
      register Sinatra::Reloader
    end

    #helpers Sinatra::Auth
    register Rack::OAuth2::Sinatra
    oauth.database = Mongo::Connection.new["corruptly"]
    oauth.authenticator = lambda do | username, password |
      user = User.find( username )
      user if user && user.authenticated?( password )
    end

    before do
      #protected!
      content_type :json
      @current_user = User.find(oauth.identity) if oauth.authenticated?
    end

    get '/oauth/authorize' do
      puts "authorize"
      #if current_user
        #render "oauth/authorize"
      #else
        #redirect "/oauth/login?authorization=#{oauth.authorization}"
      #end
      haml "oauth/authorize2"
    end

    post '/oauth/grant' do
      oauth.grant! "Superman"
    end

    post '/oauth/deny' do
      oauth.deny!
    end

    get '/' do
      election = Election.new(
        :name => '123'
      )
      election.save
      
      elec = Election.all
      
      'Hola mundo'
      elec.to_json
    end

    #Not Found
    not_found do
    end

    error 400 do
      "Bad wrong parameters"
    end

    error 401 do
      error = Error.new
      error.messages.build( :code => 401, :text => 'Access forbidden')
      error.to_json

      errors = { :errors => error.messages }
      errors.to_json
    end

    private
      def current_user=(user)
        @current_user = user
      end

  end
end
