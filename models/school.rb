require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'school/school'

# Table, each record is a school.
# It has one or many uploaders.
# It has many students.
# It has many records through these students.
class School < ActiveRecord::Base
  has_many :uploaders
  has_many :students
  has_many :records, through: :students
  include SchoolMethods
end
