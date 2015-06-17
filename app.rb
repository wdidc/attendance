require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'rest-client'
require 'httparty'
require 'json'
require './env' if File.exists?('env.rb')

enable :sessions
set :session_secret, ENV['GH_SESSION_SECRET']

CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
CLIENT_SECRET = ENV['GH_BASIC_SECRET_SECRET']
URL = ENV['GH_URL']

get '/callback' do
  session_code = request.env['rack.request.query_hash']['code']
  result = RestClient.post('https://github.com/login/oauth/access_token', {
      :client_id => ENV['GH_BASIC_CLIENT_ID'],
      :client_secret => ENV['GH_BASIC_CLIENT_SECRET'],
      :code => session_code
  },  :accept => :json)
  session['access_token'] = JSON.parse(result)['access_token']
  user = JSON.parse(RestClient.get('https://api.github.com/user?access_token=' + session['access_token']))
  session['user_name'] = user['login']
  session['avatar_url'] = user['avatar_url']
  redirect to('/');
end

get '/logout' do
  session['access_token'] = false
  redirect to('/')
end

get '/:weekday' do
  session['access_token'] ||= false
  erb :index, :locals => { 
    :weekday => params[:weekday],
    :client_id => ENV['GH_BASIC_CLIENT_ID'],
    :access_token => session['access_token'], 
    :url => URL,
    :user_name => session['user_name'],
    :avatar_url => session['avatar_url']
  }
end

get '/' do
  erb :index
end

post '/:weekday' do
  result = RestClient.post("http://localhost:2371/attendance/#{params[:weekday]}", {
    status: params[:status],
    githubUserId: params[:github_id]
  },  :accept => :json)
  redirect "/#{params[:weekday]}"
end



