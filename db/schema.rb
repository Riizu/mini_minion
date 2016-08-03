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

ActiveRecord::Schema.define(version: 20160803154449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string   "region"
    t.string   "platform_id"
    t.string   "mode"
    t.string   "type"
    t.integer  "creation"
    t.integer  "duration"
    t.string   "queue_type"
    t.integer  "map_id"
    t.string   "season"
    t.string   "version"
    t.text     "participants"
    t.text     "blue_team"
    t.text     "red_team"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "matchlists", id: false, force: :cascade do |t|
    t.integer "summoner_id"
    t.integer "match_id"
  end

  create_table "minions", force: :cascade do |t|
    t.string   "name"
    t.integer  "level",             default: 1
    t.integer  "xp",                default: 0
    t.integer  "current_health",    default: 150
    t.integer  "current_stamina",   default: 100
    t.integer  "current_happiness", default: 100
    t.integer  "total_health",      default: 150
    t.integer  "total_stamina",     default: 100
    t.integer  "total_happiness",   default: 100
    t.datetime "last_ate",          default: '2016-08-01 06:51:52'
    t.integer  "user_id"
    t.index ["user_id"], name: "index_minions_on_user_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "summoners", force: :cascade do |t|
    t.string   "name"
    t.integer  "profile_icon_id"
    t.integer  "level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_summoners_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                         null: false
    t.string   "name",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          default: 0
    t.datetime "last_match_pull"
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

  add_foreign_key "minions", "users"
  add_foreign_key "summoners", "users"
end
