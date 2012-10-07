require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'

require './models/party'

module Corruptly

  class  Parties < Application

    get '/' do
      parties = Party.all
      parties.to_json
    end

    post '/' do
      party = Party.create(
                           :name => params['name'], 
                           :logo => params['logo'], 
                           )
      party.save
      party.to_json
    end

    put '/:id' do      Candidate.remove(params['id'])
    end
  end
end
