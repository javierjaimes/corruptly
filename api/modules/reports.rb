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
                           :longitude => params['longitude'], 
                           :latitude => params['latitude'], 
                           :localization => params['localization'], 
                           :advertising_piece => params['advertising_piece'], 
                           :comments => params['comments'], 
                           )
      report.save
      report.to_json
    end

    put '/:id' do  
      
    end

    delete '/:id' do
    end
  end
end
