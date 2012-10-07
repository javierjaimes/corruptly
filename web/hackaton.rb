require 'sinatra/base'
require 'sinatra/reloader'

class Hackaton < Sinatra::Base 

	register Sinatra::Reloader

	set :protection, :except => :frame_options
	
	before do
		redirect request.url.sub(/www\./, ''), 301 if request.host =~ /^www/
	end


	get '/' do 
		erb :index
	end

	get '/newreporte' do 
		erb :newreporte
	end 

	get '/reportes' do
		erb :reportes
	end

	get '/candidato' do
		erb :candidato
	end

	get '/stats' do 

	end


	get '/css/:name.css' do
		content_type 'text/css', :charset => 'utf-8'
		scss :"css/#{params[:name]}"
	end

end
