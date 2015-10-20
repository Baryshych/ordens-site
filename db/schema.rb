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

ActiveRecord::Schema.define(version: 20151019210102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "award_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "award_types", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "award_category_id"
    t.string   "title"
    t.string   "token"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "awards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.integer  "award_type_id"
    t.integer  "document_quality_id"
    t.integer  "petition_initiator_id"
    t.string   "status"
    t.string   "result"
    t.date     "comission_date"
    t.date     "petition_got_at"
    t.string   "comission_protocol_number"
    t.string   "registry_petition_number"
    t.text     "award_cause"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "old_id"
  end

  create_table "document_qualities", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.text     "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_degrees", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "petition_initiators", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "workplace_id"
    t.integer  "years_worked_total"
    t.integer  "years_worked_on_current_place"
    t.integer  "education_degree_id"
    t.integer  "science_degree_id"
    t.date     "born_at"
    t.boolean  "male",                          default: true
    t.text     "education"
    t.text     "post"
    t.text     "characteristic"
    t.text     "archievements"
    t.text     "special_degree"
    t.text     "party_membership"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "nationality"
    t.string   "home_address"
    t.string   "home_phone"
    t.string   "work_phone"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "old_id"
  end

  create_table "science_degrees", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "post"
    t.string   "phone"
    t.text     "permissions"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workplaces", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "address"
    t.text     "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
