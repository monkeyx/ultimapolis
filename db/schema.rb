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

ActiveRecord::Schema.define(version: 20150805234746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "citizen_careers", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "profession_id"
    t.integer  "career_index"
    t.integer  "term_length"
    t.boolean  "current"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "citizen_careers", ["citizen_id", "current"], name: "index_citizen_careers_on_citizen_id_and_current", using: :btree
  add_index "citizen_careers", ["citizen_id", "profession_id", "career_index"], name: "career_mapping", using: :btree

  create_table "citizen_equipments", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "equipment_type_id"
    t.integer  "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "citizen_equipments", ["citizen_id", "equipment_type_id"], name: "index_citizen_equipments_on_citizen_id_and_equipment_type_id", using: :btree

  create_table "citizen_skills", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "skill_id"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "citizen_skills", ["citizen_id", "skill_id"], name: "index_citizen_skills_on_citizen_id_and_skill_id", using: :btree

  create_table "citizen_trade_goods", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "trade_good_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "citizen_trade_goods", ["citizen_id", "trade_good_id"], name: "index_citizen_trade_goods_on_citizen_id_and_trade_good_id", using: :btree

  create_table "citizens", force: :cascade do |t|
    t.boolean  "email_notifications"
    t.boolean  "daily_updates"
    t.boolean  "instant_updates"
    t.integer  "credits"
    t.integer  "home_district_id"
    t.integer  "current_profession_id"
    t.integer  "profession_rank"
    t.integer  "current_project_id"
    t.string   "icon"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "citizens", ["current_project_id"], name: "index_citizens_on_current_project_id", using: :btree
  add_index "citizens", ["home_district_id"], name: "index_citizens_on_home_district_id", using: :btree
  add_index "citizens", ["user_id"], name: "index_citizens_on_user_id", using: :btree

  create_table "district_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "district_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active"
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "total_land"
    t.integer  "transport_capacity"
    t.integer  "civilians"
    t.integer  "automatons"
    t.integer  "unrest"
    t.integer  "health"
    t.integer  "policing"
    t.integer  "social"
    t.integer  "environment"
    t.integer  "housing"
    t.integer  "education"
    t.integer  "community"
    t.integer  "creativity"
    t.integer  "aesthetics"
    t.integer  "crime"
    t.integer  "corruption"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "district_effects", ["district_id", "active"], name: "index_district_effects_on_district_id_and_active", using: :btree
  add_index "district_effects", ["district_id", "started_on", "expires_on"], name: "district_effects_turn", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "skill_id"
    t.integer  "total_land"
    t.integer  "free_land"
    t.integer  "transport_capacity"
    t.integer  "civilians"
    t.integer  "automatons"
    t.integer  "unrest"
    t.integer  "health"
    t.integer  "policing"
    t.integer  "social"
    t.integer  "environment"
    t.integer  "housing"
    t.integer  "education"
    t.integer  "community"
    t.integer  "creativity"
    t.integer  "aesthetics"
    t.integer  "crime"
    t.integer  "corruption"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "equipment_raw_materials", force: :cascade do |t|
    t.integer  "equipment_type_id"
    t.integer  "trade_good_id"
    t.integer  "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "equipment_raw_materials", ["equipment_type_id", "trade_good_id"], name: "erm_mapping", using: :btree

  create_table "equipment_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "skill_id"
    t.integer  "skill_modifier"
    t.integer  "exchange_price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "equipment_types", ["facility_type_id"], name: "index_equipment_types_on_facility_type_id", using: :btree

  create_table "event_resource_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "cost"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "event_resource_costs", ["event_id", "trade_good_id"], name: "index_event_resource_costs_on_event_id_and_trade_good_id", using: :btree

  create_table "event_rewards", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "equipment_type_id"
    t.integer  "facility_id"
    t.boolean  "credits",           default: false
    t.integer  "quantity"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "event_rewards", ["event_id"], name: "index_event_rewards_on_event_id", using: :btree

  create_table "event_skill_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "skill_id"
    t.integer  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_skill_costs", ["event_id", "skill_id"], name: "index_event_skill_costs_on_event_id_and_skill_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_type"
    t.integer  "started_on"
    t.integer  "finished_on"
    t.integer  "max_duration"
    t.boolean  "current"
    t.boolean  "success"
    t.text     "summary"
    t.text     "description"
    t.integer  "winning_project_id"
    t.string   "icon"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "events", ["event_type", "current"], name: "index_events_on_event_type_and_current", using: :btree
  add_index "events", ["started_on", "finished_on", "success"], name: "index_events_on_started_on_and_finished_on_and_success", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "facility_type_id"
    t.boolean  "powered"
    t.boolean  "maintained"
    t.integer  "utilised"
    t.integer  "level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "facilities", ["citizen_id", "facility_type_id"], name: "index_facilities_on_citizen_id_and_facility_type_id", using: :btree

  create_table "facility_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "district_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "build_cost"
    t.integer  "maintenance_cost"
    t.integer  "employees"
    t.integer  "automation"
    t.integer  "power_consumption"
    t.integer  "power_generation"
    t.integer  "pollution"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "facility_types", ["district_id"], name: "index_facility_types_on_district_id", using: :btree

  create_table "global_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active"
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "infrastructure_mod"
    t.integer  "grid_mod"
    t.integer  "power_mod"
    t.integer  "stability_mod"
    t.integer  "climate_mod"
    t.integer  "liberty_mod"
    t.integer  "security_mod"
    t.integer  "borders_mod"
    t.integer  "inflation_mod"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "global_effects", ["active"], name: "index_global_effects_on_active", using: :btree
  add_index "global_effects", ["started_on", "expires_on"], name: "index_global_effects_on_started_on_and_expires_on", using: :btree

  create_table "globals", force: :cascade do |t|
    t.integer  "infrastructure"
    t.integer  "grid"
    t.integer  "power"
    t.integer  "stability"
    t.integer  "climate"
    t.integer  "liberty"
    t.integer  "security"
    t.integer  "borders"
    t.integer  "turn"
    t.integer  "inflation"
    t.integer  "citizens"
    t.integer  "gdp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.string   "group"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "project_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "citizen_id"
    t.integer  "joined_on"
    t.integer  "left_on"
    t.boolean  "active"
    t.integer  "contribution"
    t.integer  "wages"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "project_members", ["project_id", "citizen_id", "active"], name: "index_project_members_on_project_id_and_citizen_id_and_active", using: :btree

  create_table "project_resources", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "trade_good_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "project_resources", ["project_id", "trade_good_id"], name: "index_project_resources_on_project_id_and_trade_good_id", using: :btree

  create_table "project_skill_points", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "skill_id"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_skill_points", ["project_id", "skill_id"], name: "index_project_skill_points_on_project_id_and_skill_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "leader_id"
    t.integer  "event_id"
    t.integer  "began_on"
    t.integer  "finished_on"
    t.string   "status"
    t.integer  "wages"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["event_id", "status"], name: "index_projects_on_event_id_and_status", using: :btree
  add_index "projects", ["leader_id"], name: "index_projects_on_leader_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "group"
    t.text     "description"
    t.string   "icon"
    t.integer  "primary_profession_id"
    t.integer  "secondary_profession_id"
    t.integer  "tertiary_profession_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "skills", ["primary_profession_id"], name: "index_skills_on_primary_profession_id", using: :btree
  add_index "skills", ["secondary_profession_id"], name: "index_skills_on_secondary_profession_id", using: :btree
  add_index "skills", ["tertiary_profession_id"], name: "index_skills_on_tertiary_profession_id", using: :btree

  create_table "trade_goods", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.integer  "exchange_price"
    t.integer  "total"
    t.integer  "produced_last_turn"
    t.integer  "for_sale"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "trade_goods", ["facility_type_id"], name: "index_trade_goods_on_facility_type_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,        null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "role",                   default: "player"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
