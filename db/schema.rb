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

ActiveRecord::Schema.define(version: 20131020050606) do

  create_table "grunts", force: true do |t|
    t.integer  "yak_id"
    t.text     "message"
    t.float    "geo_lat"
    t.float    "geo_long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herd_grunts", force: true do |t|
    t.integer  "grunt_id"
    t.integer  "herd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yaks", force: true do |t|
    t.string   "name"
    t.string   "auth_hash"
    t.float    "geo_lat"
    t.float    "geo_long"
    t.integer  "herd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
