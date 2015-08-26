require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'rest-client'
require 'httparty'
require 'json'
require './env' if File.exists?('env.rb')

enable :sessions
set :session_secret, ENV.fetch('SESSION_SECRET')

# TODO: move to GitHub class
GH_CLIENT_ID = ENV.fetch('GH_BASIC_CLIENT_ID')
GH_CLIENT_SECRET = ENV.fetch('GH_BASIC_CLIENT_SECRET')
GH_OAUTH_CALLBACK_PATH = "/auth/github/callback"

get '/' do
  erb :index
end

get GH_OAUTH_CALLBACK_PATH do
  session_code = request.env['rack.request.query_hash']['code']
  result = RestClient.post('https://github.com/login/oauth/access_token', {
      :client_id => GH_CLIENT_ID,
      :client_secret => GH_CLIENT_SECRET,
      :code => session_code
  },  :accept => :json)

  if result['error']
    fail result
  else
    session['access_token'] = JSON.parse(result).fetch('access_token')
    user = JSON.parse(RestClient.get('https://api.github.com/user?access_token=' + session['access_token']))
    session['user_name'] = user['login']
    session['avatar_url'] = user['avatar_url']
    redirect to('/');
  end
end

get '/logout' do
  session['access_token'] = false
  redirect to('/')
end

get '/util/routes' do
  route_list = []
  Sinatra::Application.routes.each do |http_verb, routes|
    route_list += routes.collect {|route| "#{http_verb}: #{route[0].inspect}"}
  end
  route_list.inspect
end

get '/:weekday' do
  session['access_token'] ||= false
  erb :weekday, :locals => {
    :weekday => params[:weekday],
    :client_id => GH_CLIENT_ID,
    :access_token => session['access_token'],
    :url => request.base_url,
    :user_name => session['user_name'],
    :avatar_url => session['avatar_url']
  }
end

post '/:weekday' do
  result = RestClient.post("http://api.wdidc.org/attendance/#{params[:weekday]}?access_token=#{session['access_token']}", {
    status: params[:status],
    githubUserId: params[:github_id]
  },  :accept => :json)
  return result.to_json
end

helpers do
  def github_oauth_callback_url
    # build url using current url + callback path
    URI.join(request.base_url, GH_OAUTH_CALLBACK_PATH)
  end

  def github_oauth_authorize_url
    # original "https://github.com/login/oauth/authorize?redirect_uri=<%= github_oauth_callback_url %>&scope=repo&client_id=<%= GH_CLIENT_ID %>
    query_params = [
      "redirect_uri=#{CGI.escape(github_oauth_callback_url.to_s)}",
      "scope=repo",
      "client_id=#{GH_CLIENT_ID}"
    ]
    URI::HTTPS.build(
      host: 'github.com',
      path: '/login/oauth/authorize',
      query: query_params.join('&')
    )
  end
end
