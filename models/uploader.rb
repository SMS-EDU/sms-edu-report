require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'uploader/uploader'

# Each record is a file containing student records
class Uploader < ActiveRecord::Base
  include UploaderMethods
end
