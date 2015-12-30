require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'uploader/uploader'

# Table, each record is an uploader.
# It belongs to a school.
# It has many records.
class Uploader < ActiveRecord::Base
  belongs_to :school
  has_many :records
  include UploaderMethods

  validates :encrypted_last_name, presence: true
  validates :encrypted_first_name, presence: true
  validates :encrypted_email, presence: true
  validates :school_id, presence: true
end
