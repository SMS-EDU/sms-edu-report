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

  get_schools = lambda do
    begin
      SchoolsFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_schools = lambda do
    begin
      SaveSchoolsToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_schools = lambda do
  end

  delete_schools = lambda do
  end

  get_guardians = lambda do
    begin
      GuardianFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_guardians = lambda do
    begin
      SaveGuardiansToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_guardians = lambda do
  end

  delete_guardians = lambda do
  end

  get_uploaders = lambda do
    begin
      UploaderFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_uploaders = lambda do
    begin
      SaveUploadersToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_uploaders = lambda do
  end

  delete_uploaders = lambda do
  end

  get_students = lambda do
  end

  post_students = lambda do
  end

  put_students = lambda do
  end

  delete_students = lambda do
  end

  get_records = lambda do
    begin
      RecordFromDB.new(params).call
    rescue => e
      logger.error("Fail: #{e}")
      halt 500
    end
  end

  post_records = lambda do
    begin
      SaveRecordsToDB.new(params).call
      201
    rescue => e
      logger.error("Fail: #{e}")
      halt 400
    end
  end

  put_records = lambda do
  end

  delete_records = lambda do
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

  # School routes
  get '/api/v1/schools/?', &get_schools
  post '/api/v1/schools/?', &post_schools
  put '/api/v1/schools/?', &put_schools
  delete '/api/v1/schools/?', &delete_schools

  # Guardian routes
  get '/api/v1/guardians/?', &get_guardians
  post '/api/v1/guardians/?', &post_guardians
  put '/api/v1/guardians/?', &put_guardians
  delete '/api/v1/guardians/?', &delete_guardians

  # Uploader routes
  get '/api/v1/uploaders/?', &get_uploaders
  post '/api/v1/uploaders/?', &post_uploaders
  put '/api/v1/uploaders/?', &put_uploaders
  delete '/api/v1/uploaders/?', &delete_uploaders

  # Student routes
  get '/api/v1/students/?', &get_students
  post '/api/v1/students/?', &post_students
  put '/api/v1/students/?', &put_students
  delete '/api/v1/students/?', &delete_students

  # Student Records core routes
  get '/api/v1/records/?', &get_records
  post '/api/v1/records/?', &post_records
  put '/api/v1/records/?', &put_records
  delete '/api/v1/records/?', &delete_records

  post '/api/v1/process_data/?', &post_process_data
  get '/oauth2callback/?', &callback_gmail
end
