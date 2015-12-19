require 'sinatra'
# require 'sinatra/base'
require 'config_env'
require 'rack/ssl-enforcer'
require 'httparty'
require 'jwt'
require 'json'
require 'rbnacl/libsodium'

configure :development, :test do
  require 'hirb'
  Hirb.enable
  absolute_path = File.absolute_path './config/config_env.rb'
  ConfigEnv.path_to_config(absolute_path)
end

# Controller Class
class ApplicationController < Sinatra::Base
  enable :logging

  configure :production do
    use Rack::SslEnforcer
    set :session_secret, ENV['MSG_KEY']
  end

  configure do
    use Rack::Session::Pool, secret: settings.session_secret
  end

  api_get_root = lambda do
    'Welcome to api/v1'
  end

  post_user_data = lambda do
  end

  process_user_data = lambda do
  end

  ['/', '/api/v1/?'].each { |path| get path, &api_get_root }
  get '/api/v1/post_user_data/?', &post_user_data
  get '/api/v1/process_user_data/?', &process_user_data
end
