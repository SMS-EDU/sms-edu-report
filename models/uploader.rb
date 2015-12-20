require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
# require_relative 'model_helper'

# Each record is a file containing student records
class Uploader < ActiveRecord::Base
end
