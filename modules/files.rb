require './helpers/auth'

require './models/report'

module Corruptly

  class Files < Application

    get '/:id' do
      report = Report.where(:id => id).first()
      file = report.file
      
      [200, {'Content-Type' => file.content_type}, [file.read]]
    end

  end
end
