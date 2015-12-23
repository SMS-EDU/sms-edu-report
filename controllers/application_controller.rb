require 'sinatra'
require 'config_env'
require 'rack/ssl-enforcer'
require 'httparty'
require 'jwt'
require 'json'
require 'rbnacl/libsodium'
require 'csv'
require_relative '../services/init.rb'

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

  get_student_records = lambda do
    begin
      RecordFromDB.new(params).call
    # rescue => e
    #   logger.error("Fail: #{e}")
    #   halt 500
    end
  end

  post_student_records = lambda do
    begin
      SaveRecordsToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_student_records = lambda do
  end

  delete_student_records = lambda do
  end

  get_guardian = lambda do
    begin
      GuardianFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_guardian = lambda do
    begin
      SaveGuardiansToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_guardian = lambda do
  end

  delete_guardian = lambda do
  end

  get_uploader = lambda do
    begin
      UploaderFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_uploader = lambda do
    begin
      SaveUploadersToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_uploader = lambda do
  end

  delete_uploader = lambda do
  end

  post_process_data = lambda do
  end

  callback_gmail = lambda do
    access_token = CallbackGmail.new(params, request).call
    email = GoogleTeacherEmail.new(access_token).call
    "#{email}"
  end

  # Root route
  ['/', '/api/v1/?'].each { |path| get path, &api_get_root }

  # Student Records core routes
  get '/api/v1/student_record/?', &get_student_records
  post '/api/v1/student_record/?', &post_student_records
  put '/api/v1/student_record/?', &put_student_records
  delete '/api/v1/student_record/?', &delete_student_records

  # Guardian routes
  get '/api/v1/guardian/?', &get_guardian
  post '/api/v1/guardian/?', &post_guardian
  put '/api/v1/guardian/?', &put_guardian
  delete '/api/v1/guardian/?', &delete_guardian

  # Uploader routes
  get '/api/v1/uploader/?', &get_uploader
  post '/api/v1/uploader/?', &post_uploader
  put '/api/v1/uploader/?', &put_uploader
  delete '/api/v1/uploader/?', &delete_uploader

  post '/api/v1/process_data/?', &post_process_data
  get '/oauth2callback/?', &callback_gmail
end
