require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
# require_relative 'model_helper'

# Table, each record is a student with her/his guardians
class Guardian < ActiveRecord::Base
end
