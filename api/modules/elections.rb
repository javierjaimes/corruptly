require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'

require './models/election'

module Corruptly

  class Elections < Application

    get '/' do
      elections = Election.all
      elections.to_json
    end

    post '/' do
      election = Election.create(
                                 :name => params['name'], 
                                 :corporation => params['corporation'], 
                                 :year => params['year'], 
                                 )
      election.save
      election.to_json
    end

    put '/:id' do
      Election.all

    end

    delete '/:id' do
	Candidate.destroy(params['id'])

    end
  end
end
