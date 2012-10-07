require 'rubygems'
require 'rest_client'

url ='http://corruptly.herokuapp.com/reports'

response = RestClient.get(url)

puts response.body
