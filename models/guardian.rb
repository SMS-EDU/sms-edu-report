require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'guardian/guardian'

# Table, each record is a guardian.
# It has one or many students.
# It has many records through these students.
class Guardian < ActiveRecord::Base
  has_many :students
  has_many :records, through: :students
  include GuardianMethods

  validates :encrypted_name, presence: true
  validates :encrypted_phone_number, presence: true
end
