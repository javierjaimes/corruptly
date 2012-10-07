require './helpers/auth'
require './models/candidate'

module Corruptly

  class Candidate < Application

    get '/' do
      candidates = Candidate.all
      candidates.to_json
    end

    post '/' do
      candidate = Candidate.create(
        :name => params['name'], 
        :list_number => params['list_number'], 
        :position => params['position'], 
      )
      candidate.save
      candidate.to_json
    end

    put '/:id' do

    end

    delete '/:id' do

    end

  end

end
