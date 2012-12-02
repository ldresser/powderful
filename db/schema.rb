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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121201213941) do

  create_table "droutes", :force => true do |t|
    t.string   "origin"
    t.integer  "resort_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "drive_time_int"
    t.string   "drive_time_str"
    t.integer  "distance_int"
    t.string   "distance_str"
    t.string   "resort_address"
  end

  create_table "resorts", :id => false, :force => true do |t|
    t.integer  "id"
    t.string   "name"
    t.integer  "runs"
    t.float    "pr_beginner"
    t.float    "pr_intermediate"
    t.float    "pr_advanced"
    t.float    "pr_expert"
    t.integer  "area"
    t.integer  "elevation_base"
    t.integer  "elevation_peak"
    t.integer  "vertical_drop"
    t.integer  "longest_trail"
    t.integer  "lifts"
    t.string   "url"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "trail_map"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "snowcountryid"
    t.integer  "drive_time_int"
    t.string   "drive_time_str"
    t.integer  "distance_int"
    t.string   "distance_str"
  end

  create_table "resorts_backup", :id => false, :force => true do |t|
    t.integer  "id"
    t.string   "name"
    t.integer  "runs"
    t.float    "pr_beginner"
    t.float    "pr_intermediate"
    t.float    "pr_advanced"
    t.float    "pr_expert"
    t.integer  "area"
    t.integer  "elevation_base"
    t.integer  "elevation_peak"
    t.integer  "vertical_drop"
    t.integer  "longest_trail"
    t.integer  "lifts"
    t.string   "url"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "trail_map"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "snowcountryid"
  end

  create_table "userlocations", :force => true do |t|
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uAddress"
  end

end
