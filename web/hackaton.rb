require "sinatra/base"
require "sinatra/reloader"
require 'rubygems'
require './modules/modules'
require "json"
require "httparty"

class Hackaton < Sinatra::Base
	helpers Sinatra::BotticoHelpers

	register Sinatra::Reloader

	set :protection, :except => :frame_options

	before do
		redirect reqyest.url.sub(/www\./, ''), 301 if request.host =~ /^www/
	end

	get '/' do
		erb :index
	end

	get '/reportes' do
		@rest = HTTParty.get('http://corruptly.herokuapp.com/reports')
		@cand = HTTParty.get('http://corruptly.herokuapp.com/candidates')
		erb :reportes
	end

	get '/reportes/nuevo' do
		erb :newreporte
	end
	
	get '/reportes/:id' do
		@rest = HTTParty.get('http://corruptly.herokuapp.com/reports')
		erb :reporte
	end

	get '/about' do
		erb :about
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
