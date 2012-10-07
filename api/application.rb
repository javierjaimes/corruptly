require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require "rack/oauth2/sinatra"
require 'sinatra/reloader'
require './helpers/auth'


puts MongoMapper.database = 'corruptly' 
puts MongoMapper.connection

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
    oauth.database = MongoMapper.connection
    oauth.authenticator = lambda do | username, password |
      user = User.find( username )
      user if user && user.authenticated?( password )
    end

    get "/oauth/authorize" do
      if current_user
        render "oauth/authorize"
      else
        redirect "/oauth/login?authorization=#{oauth.authorization}"
      end
    end

    post "/oauth/grant" do
      oauth.grant! "Superman"
    end

    post "/oauth/deny" do
      oauth.deny!
    end

    get '/' do
      
      'Hola mundo'
    end


    before do
      #protected!
      content_type :json
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

  end
end
