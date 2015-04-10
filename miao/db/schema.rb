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

ActiveRecord::Schema.define(version: 20150410064247) do

  create_table "addrs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "longitude",  limit: 255
    t.string   "latitude",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "china_cities", force: :cascade do |t|
    t.integer  "area_code",   limit: 4
    t.string   "area",        limit: 255
    t.integer  "parent_code", limit: 4
    t.integer  "level",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   limit: 4,                   null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",     limit: 4,                   null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",         limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "twitter_id", limit: 4
    t.string   "url",        limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "twitters", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.string   "source",     limit: 255
    t.string   "url",        limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "anonymous",  limit: 4
    t.string   "longitude",  limit: 255
    t.string   "latitude",   limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

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
    t.integer  "university_id",          limit: 4
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
