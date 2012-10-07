require './models/user'
module Corruptly

  class Users < Application

    #helpers Sinatra::Auth
    #


    get '/' do
      users = User.all
      users.to_json
    end

    post '/' do
      puts params
      user = User.create(
        :email => params[ :email ],
        :password => params[ :password ],
        :developer =>  params[ :developer ]
      )

      unless user.save
        throw( :halt, [400, "Wrong parameters" ] )
      end

      user.to_json
    end

    put '/:id' do
      'Hola users put'
    end

    delete '/:id' do
      'Hola users delete'
    end
  end
end
