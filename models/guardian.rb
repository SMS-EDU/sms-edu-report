require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'guardian/guardian'

# Table, each record is a student with her/his guardians
class Guardian < ActiveRecord::Base
  include GuardianMethods
end
