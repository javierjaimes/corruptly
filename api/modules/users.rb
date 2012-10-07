require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'

module Corruptly

  class Users < Application

    helpers Sinatra::Auth


    get '/' do
      'Hola users'

    end

    post '/' do
      'Hola users post'

    end

    put '/:id' do
      'Hola users put'
    end

    delete '/:id' do
      'Hola users delete'
    end
  end
end
