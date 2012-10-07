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
        :candidate_id => params['candidate_id'],
      )
      report.file = params[ :file ][ :tempfile ] if params[ :file ]
      report.file_name = params[ :file ][ :filename ] if params[ :file ]
      report.save
      
      # Save attachment
      report.to_json
      #asset = Asset.create(:file => params[:file][:tempfile])
        # this changes the name so that when downloading the 'proper' name is preserved
      #   asset.file_name = params[:file][:filename]
      #     asset.save
      #       partial :asset, :locals => {:asset => asset}
    end

    get '/:id' do
      report = Report.find(params[:id])
      report.to_json
    end
    
    put '/:id' do  

    end

    delete '/:id' do
    end
  end
end
