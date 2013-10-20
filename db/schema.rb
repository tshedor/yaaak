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

ActiveRecord::Schema.define(version: 20131019031139) do

  create_table "grunts", force: true do |t|
    t.integer  "yak_id"
    t.integer  "herd_id"
    t.text     "message"
    t.float    "geo_lat"
    t.float    "geo_long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grunts", ["herd_id"], name: "index_grunts_on_herd_id", using: :btree
  add_index "grunts", ["yak_id"], name: "index_grunts_on_yak_id", using: :btree

  create_table "herds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yaks", force: true do |t|
    t.string   "name"
    t.string   "auth_hash"
    t.float    "geo_lat"
    t.float    "geo_long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
