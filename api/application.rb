require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'


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
