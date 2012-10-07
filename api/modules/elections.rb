require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'


MongoMapper.database = ''

module Corruptly

  class Elections < Application

    key :name, String
    key :corporation, String
    key :year, Integer

    include MongoMapper::Document


    get '/' do
      
    end

    post '/' do
      
    end

    put '/:id' do

    end

    delete '/:id' do

    end
  end
end
