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

ActiveRecord::Schema.define(version: 20151109012208) do

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "league_id"
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "game_time"
    t.integer  "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "game_date"
  end

  add_index "games", ["field_id"], name: "index_games_on_field_id"
  add_index "games", ["game_date"], name: "index_games_on_game_date"
  add_index "games", ["league_id"], name: "index_games_on_league_id"
  add_index "games", ["team_1_id"], name: "index_games_on_team_1_id"
  add_index "games", ["team_2_id"], name: "index_games_on_team_2_id"

  create_table "league_team_lists", force: :cascade do |t|
    t.integer  "league_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "league_team_lists", ["league_id", "team_id"], name: "index_league_team_lists_on_league_id_and_team_id", unique: true
  add_index "league_team_lists", ["league_id"], name: "index_league_team_lists_on_league_id"
  add_index "league_team_lists", ["team_id"], name: "index_league_team_lists_on_team_id"

  create_table "leagues", force: :cascade do |t|
    t.string  "name"
    t.boolean "mon"
    t.integer "mon_first_game"
    t.integer "mon_last_game"
    t.boolean "tues"
    t.integer "tues_first_game"
    t.integer "tues_last_game"
    t.boolean "weds"
    t.integer "weds_first_game"
    t.integer "weds_last_game"
    t.boolean "thurs"
    t.integer "thurs_first_game"
    t.integer "thurs_last_game"
    t.boolean "fri"
    t.integer "fri_first_game"
    t.integer "fri_last_game"
    t.boolean "sat"
    t.integer "sat_first_game"
    t.integer "sat_last_game"
    t.boolean "sun"
    t.integer "sun_first_game"
    t.integer "sun_last_game"
    t.date    "first_game_date"
    t.date    "last_game_date"
    t.integer "number_of_games"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "contact_name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "before_req"
    t.integer  "before_req_time"
    t.boolean  "after_req"
    t.integer  "after_req_time"
    t.boolean  "day_req_0"
    t.boolean  "day_req_0_before_after"
    t.integer  "day_req_0_time"
    t.date     "day_req_0_date"
    t.boolean  "day_req_1"
    t.boolean  "day_req_1_before_after"
    t.integer  "day_req_1_time"
    t.date     "day_req_1_date"
    t.boolean  "day_req_2"
    t.boolean  "day_req_2_before_after"
    t.integer  "day_req_2_time"
    t.date     "day_req_2_date"
    t.boolean  "day_req_3"
    t.boolean  "day_req_3_before_after"
    t.integer  "day_req_3_time"
    t.date     "day_req_3_date"
    t.boolean  "day_req_4"
    t.boolean  "day_req_4_before_after"
    t.integer  "day_req_4_time"
    t.date     "day_req_4_date"
    t.boolean  "day_req_5"
    t.boolean  "day_req_5_before_after"
    t.integer  "day_req_5_time"
    t.date     "day_req_5_date"
    t.boolean  "day_req_6"
    t.boolean  "day_req_6_before_after"
    t.integer  "day_req_6_time"
    t.date     "day_req_6_date"
    t.boolean  "day_req_7"
    t.boolean  "day_req_7_before_after"
    t.integer  "day_req_7_time"
    t.date     "day_req_7_date"
    t.boolean  "day_req_8"
    t.boolean  "day_req_8_before_after"
    t.integer  "day_req_8_time"
    t.date     "day_req_8_date"
    t.boolean  "day_req_9"
    t.boolean  "day_req_9_before_after"
    t.integer  "day_req_9_time"
    t.date     "day_req_9_date"
  end

end
