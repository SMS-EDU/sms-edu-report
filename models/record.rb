require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'record/record'

# Each record is a file containing student records.
# It belongs to a student AND an uploader.
class Record < ActiveRecord::Base
  belongs_to :student
  belongs_to :uploader
  include RecordMethods
end
