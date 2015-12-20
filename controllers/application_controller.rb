require 'sinatra'
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

# Controller Class - Go to bottom for list of routes
class ApplicationController < Sinatra::Base
  enable :logging
  use Rack::MethodOverride

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

  post_student_data = lambda do
  end

  put_student_data = lambda do
  end

  delete_student_data = lambda do
  end

  post_process_data = lambda do
  end

  callback_gmail = lambda do
    access_token = CallbackGmail.new(params, request).call
    email = GoogleTeacherEmail.new(access_token).call
    "#{email}"
  end

  ['/', '/api/v1/?'].each { |path| get path, &api_get_root }
  post '/api/v1/student_data/?', &post_student_data
  put '/api/v1/student_data/?', &put_student_data
  delete '/api/v1/student_data/?', &delete_student_data
  post '/api/v1/process_data/?', &post_process_data
  get '/oauth2callback/?', &callback_gmail
end
