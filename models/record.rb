require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'record/record'

# Each record is a file containing student records.
# It belongs to a student AND an uploader.
class Record < ActiveRecord::Base
  belongs_to :uploader
  include RecordMethods

  validates :record_type, presence: true
  validates :encrypted_session, presence: true
  validates :encrypted_term, presence: true
  validates :encrypted_class, presence: true
  validates :encrypted_record_json, presence: true
  validates :uploader_id, presence: true
end
