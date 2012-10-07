module Sinatra

    module Auth
      def protected!
        query = request.query_string
        unless query.match( 'oauth_token=' )
          throw( :halt, [ 401, "Unauthorized" ])
        end
        token =  Rack::OAuth2::Server::get_access_token query.gsub /^oauth_token=/, ''
        token.identity if token
      end

      def authorized?
      end

  end

    helpers Auth
end
