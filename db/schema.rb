# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151220005114) do

  create_table "guardians", force: :cascade do |t|
    t.text     "encrypted_phone_number"
    t.text     "encrypted_guardian_name"
    t.text     "encrypted_student_name"
    t.text     "encrypted_nonce"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "records", force: :cascade do |t|
    t.text     "encrypted_uploader_email"
    t.text     "record_type"
    t.text     "encrypted_record_json"
    t.text     "encrypted_nonce"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "uploaders", force: :cascade do |t|
    t.text     "encrypted_email"
    t.text     "encrypted_school"
    t.text     "encrypted_name"
    t.text     "hashed_password"
    t.text     "encoded_nonce"
    t.text     "encoded_salt"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
