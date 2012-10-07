require 'json'
require 'mongo'
require 'mongo_mapper'
require 'sinatra/base'
require 'sinatra/reloader'
require './helpers/auth'

require './models/report'

module Corruptly

  class  Reports < Application

    get '/' do
      reports = Report.all
      reports.to_json
    end

    post '/' do
      report = Report.create(
        :location => params['location'],
        :advertising_piece => params['advertising_piece'], 
        :description => params['description'],
        :candidate_id => params['candidate_id']
      )
      report.save
      
      # Save attachment
      report.to_json
    end

    put '/:id' do  

    end

    delete '/:id' do
    end
  end
end
