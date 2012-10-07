require './helpers/auth'
require './models/candidate'

module Corruptly

  class Candidates < Application

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
<<<<<<< HEAD
	Candidate.destroy(params['id'])
      
=======

>>>>>>> 41581b59ac38c753d49ae10fd83967b9c4fae227
    end

  end

end
