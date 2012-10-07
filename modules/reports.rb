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
        :file => params[ :file ][ :tempfile ]
      )
      report.file_name = params[ :file ][ :filename ]
      report.save
      
      # Save attachment
      report.to_json
      #asset = Asset.create(:file => params[:file][:tempfile])
        # this changes the name so that when downloading the 'proper' name is preserved
      #   asset.file_name = params[:file][:filename]
      #     asset.save
      #       partial :asset, :locals => {:asset => asset}
    end

    put '/:id' do  

    end

    delete '/:id' do
    end
  end
end
