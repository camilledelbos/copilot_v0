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

ActiveRecord::Schema.define(version: 20140727202134) do

  create_table "climates", force: true do |t|
    t.string  "couple"
    t.string  "country"
    t.string  "main_city"
    t.string  "month"
    t.integer "sunshine_duration"
    t.float   "t_average_min"
    t.float   "t_average_max"
    t.float   "t_average"
    t.float   "t_best_min"
    t.float   "t_best_max"
    t.float   "precipitation"
    t.integer "rainy_days"
    t.integer "notation"
  end

  create_table "continents", force: true do |t|
    t.string   "continent_code"
    t.string   "continent_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "country_code"
    t.string   "capital"
    t.integer  "pop_density"
    t.string   "geo_zone"
    t.integer  "surface_area"
    t.integer  "pop_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "daily_budget"
    t.integer  "copilot_rate"
  end

  create_table "januaries", force: true do |t|
    t.string  "main_city"
    t.integer "sunshine_duration"
    t.integer "t_average_min"
    t.integer "t_average_max"
    t.integer "t_best_min"
    t.integer "t_best_max"
    t.integer "precipitation"
    t.integer "rainy_days"
    t.integer "humidity"
  end

  create_table "main_cities", force: true do |t|
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps", force: true do |t|
    t.string   "map_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "departure_date"
  end

  create_table "prospects", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "prospects", ["user_id"], name: "index_prospects_on_user_id"

  create_table "routes", force: true do |t|
    t.string   "route_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "travel_id"
    t.integer  "route_position"
  end

  create_table "stages", force: true do |t|
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "route_id"
    t.date     "departure_date"
    t.integer  "stage_position"
    t.integer  "travel_id"
  end

  add_index "stages", ["route_id"], name: "index_stages_on_route_id"
  add_index "stages", ["travel_id"], name: "index_stages_on_travel_id"

  create_table "travels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "nb_traveller"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
