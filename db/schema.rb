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

ActiveRecord::Schema.define(version: 20151230023605) do

  create_table "guardians", force: :cascade do |t|
    t.text     "encrypted_phone_number"
    t.text     "encrypted_name"
    t.text     "encrypted_email"
    t.text     "encoded_nonce"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "uploader_id"
    t.text     "record_type"
    t.text     "encrypted_session"
    t.text     "encrypted_term"
    t.text     "encrypted_class"
    t.text     "encrypted_record_json"
    t.text     "encoded_nonce"
    t.text     "sent?",                 default: "f"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "records", ["uploader_id"], name: "index_records_on_uploader_id"

  create_table "schools", force: :cascade do |t|
    t.text     "encrypted_phone_number"
    t.text     "encrypted_name"
    t.text     "encrypted_email"
    t.text     "encoded_nonce"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "guardian_id"
    t.text     "encrypted_first_name"
    t.text     "encrypted_last_name"
    t.text     "encrypted_student_school_id"
    t.text     "encoded_nonce"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "students", ["guardian_id"], name: "index_students_on_guardian_id"
  add_index "students", ["school_id"], name: "index_students_on_school_id"

  create_table "uploaders", force: :cascade do |t|
    t.integer  "school_id"
    t.text     "encrypted_first_name"
    t.text     "encrypted_last_name"
    t.text     "encrypted_email"
    t.text     "encrypted_phone_number"
    t.text     "hashed_password"
    t.text     "encoded_nonce"
    t.text     "encoded_salt"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "uploaders", ["school_id"], name: "index_uploaders_on_school_id"

end
