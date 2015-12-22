require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'record/record'

# Each record is a file containing student records
class Record < ActiveRecord::Base
  include RecordMethods
end
