require 'sinatra'
require 'sinatra/activerecord'
require_relative '../config/environments'
require_relative 'student/student'

# Table, each record is a student.
# It belongs to a guardian.
# It belongs to a school.
# It has many records.
class Student < ActiveRecord::Base
  belongs_to :guardian
  belongs_to :school
  has_many :records
  include StudentMethods

  validates :encrypted_student_school_id, presence: true
  validates :encrypted_last_name, presence: true
  validates :encrypted_first_name, presence: true
  validates :school_id, presence: true
  # validates :guardian_id, presence: true
end
