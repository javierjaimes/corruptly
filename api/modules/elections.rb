require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'

require './models/election'

MongoMapper.database = ''

module Corruptly

  class Elections < Application

    get '/' do
      Election.all
    end

    post '/' do
      Election.create(:name => request[:name], :corporation => request[:corporation], :year => request[:year])
      {"amaury" => "amaury"}.to_json
    end

    put '/:id' do
      Election.all

    end

    delete '/:id' do

    end
  end
end
