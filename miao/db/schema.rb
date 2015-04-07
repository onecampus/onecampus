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

ActiveRecord::Schema.define(version: 20150407082448) do

  create_table "users", force: :cascade do |t|
    t.string   "last_name",              limit: 255
    t.string   "first_name",             limit: 255
    t.string   "nick_name",              limit: 255
    t.string   "uid",                    limit: 255
    t.string   "salt",                   limit: 255
    t.string   "pass",                   limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "email",                  limit: 255
    t.integer  "age",                    limit: 4
    t.string   "university",             limit: 255
    t.string   "address_current",        limit: 255
    t.datetime "birthday"
    t.string   "mobile",                 limit: 255
    t.string   "gender",                 limit: 255
    t.string   "access_token",           limit: 255
    t.datetime "expiration_time"
    t.string   "last_login_ip",          limit: 255
    t.string   "register_status",        limit: 255
    t.datetime "last_sign_in_at"
    t.string   "language",               limit: 255
    t.string   "register_type",          limit: 255
    t.text     "personalized_signature", limit: 65535
    t.string   "country",                limit: 255
    t.string   "province",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "region",                 limit: 255
    t.string   "postcode",               limit: 255
    t.string   "tel",                    limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

end
