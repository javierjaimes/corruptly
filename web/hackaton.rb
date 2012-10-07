require "sinatra/base"
require "sinatra/reloader"
require 'rubygems'
#require "rest_client"
require "json"
require "httparty"

class Hackaton < Sinatra::Base

	register Sinatra::Reloader

	set :protection, :except => :frame_options

	before do
		redirect reqyest.url.sub(/www\./, ''), 301 if request.host =~ /^www/
	end

	get '/' do
		erb :index
	end

	get '/reporte/:id' do
		erb :reporte
	end

	get '/about' do
		erb :about
	end

	get '/newreporte' do
		erb :newreporte
	end

	get '/reportes' do
		@rest = HTTParty.get('http://corruptly.herokuapp.com/reports')

		erb :reportes
	end

	get '/candidato' do
		erb :candidato
	end

	get '/stats' do
		
	end

	get '/restget' do
		
	end

	get '/css/:name.css' do
		content_type 'text/css', :charset => 'utf-8'
		scss :"css/#{params[:name]}"
	end

end
