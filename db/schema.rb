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

ActiveRecord::Schema.define(version: 20150809073659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogit_comments", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "website"
    t.text     "body",       null: false
    t.integer  "post_id",    null: false
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogit_comments", ["post_id"], name: "index_blogit_comments_on_post_id", using: :btree

  create_table "blogit_posts", force: :cascade do |t|
    t.string   "title",                            null: false
    t.text     "body",                             null: false
    t.string   "state",          default: "draft", null: false
    t.integer  "comments_count", default: 0,       null: false
    t.integer  "blogger_id"
    t.string   "blogger_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "blogit_posts", ["blogger_type", "blogger_id"], name: "index_blogit_posts_on_blogger_type_and_blogger_id", using: :btree

  create_table "bonds", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "value",      limit: 8
    t.integer  "issued_on"
    t.integer  "matures_on"
    t.integer  "interest"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "citizen_careers", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "profession_id"
    t.integer  "career_index",  default: 0
    t.integer  "term_length",   default: 0
    t.boolean  "current",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "citizen_careers", ["citizen_id", "current"], name: "index_citizen_careers_on_citizen_id_and_current", using: :btree
  add_index "citizen_careers", ["citizen_id", "profession_id", "career_index"], name: "career_mapping", using: :btree

  create_table "citizen_equipments", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "equipment_type_id"
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "citizen_equipments", ["citizen_id", "equipment_type_id"], name: "index_citizen_equipments_on_citizen_id_and_equipment_type_id", using: :btree

  create_table "citizen_skills", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "skill_id"
    t.integer  "rank",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "citizen_skills", ["citizen_id", "skill_id"], name: "index_citizen_skills_on_citizen_id_and_skill_id", using: :btree

  create_table "citizen_trade_goods", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",      default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "citizen_trade_goods", ["citizen_id", "trade_good_id"], name: "index_citizen_trade_goods_on_citizen_id_and_trade_good_id", using: :btree

  create_table "citizens", force: :cascade do |t|
    t.boolean  "email_notifications",             default: true
    t.boolean  "daily_updates",                   default: false
    t.boolean  "instant_updates",                 default: true
    t.integer  "credits",               limit: 8, default: 0
    t.integer  "home_district_id"
    t.integer  "current_profession_id"
    t.integer  "profession_rank",                 default: 0
    t.integer  "current_project_id"
    t.string   "icon"
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "citizens", ["current_project_id"], name: "index_citizens_on_current_project_id", using: :btree
  add_index "citizens", ["home_district_id"], name: "index_citizens_on_home_district_id", using: :btree
  add_index "citizens", ["user_id"], name: "index_citizens_on_user_id", using: :btree

  create_table "district_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "district_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active",             default: true
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "total_land",         default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "district_effects", ["district_id", "active"], name: "index_district_effects_on_district_id_and_active", using: :btree
  add_index "district_effects", ["district_id", "started_on", "expires_on"], name: "district_effects_turn", using: :btree

  create_table "district_snapshots", force: :cascade do |t|
    t.integer  "district_id"
    t.integer  "turn"
    t.integer  "total_land",         default: 0
    t.integer  "free_land",          default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "district_snapshots", ["district_id", "turn"], name: "index_district_snapshots_on_district_id_and_turn", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "skill_id"
    t.integer  "total_land",         default: 0
    t.integer  "free_land",          default: 0
    t.integer  "transport_capacity", default: 0
    t.integer  "civilians",          default: 0
    t.integer  "automatons",         default: 0
    t.integer  "unrest",             default: 0
    t.integer  "health",             default: 0
    t.integer  "policing",           default: 0
    t.integer  "social",             default: 0
    t.integer  "environment",        default: 0
    t.integer  "housing",            default: 0
    t.integer  "education",          default: 0
    t.integer  "community",          default: 0
    t.integer  "creativity",         default: 0
    t.integer  "aesthetics",         default: 0
    t.integer  "crime",              default: 0
    t.integer  "corruption",         default: 0
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree

  create_table "equipment_raw_materials", force: :cascade do |t|
    t.integer  "equipment_type_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "equipment_raw_materials", ["equipment_type_id", "trade_good_id"], name: "erm_mapping", using: :btree

  create_table "equipment_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "skill_id"
    t.integer  "skill_modifier",   default: 0
    t.integer  "exchange_price",   default: 0
    t.integer  "for_sale",         default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "equipment_types", ["facility_type_id"], name: "index_equipment_types_on_facility_type_id", using: :btree

  create_table "event_resource_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "cost",          default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "event_resource_costs", ["event_id", "trade_good_id"], name: "index_event_resource_costs_on_event_id_and_trade_good_id", using: :btree

  create_table "event_rewards", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "trade_good_id"
    t.integer  "equipment_type_id"
    t.integer  "facility_type_id"
    t.boolean  "credits",           default: false
    t.integer  "quantity",          default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "event_rewards", ["event_id"], name: "index_event_rewards_on_event_id", using: :btree

  create_table "event_skill_costs", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "skill_id"
    t.integer  "cost",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "event_skill_costs", ["event_id", "skill_id"], name: "index_event_skill_costs_on_event_id_and_skill_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_type"
    t.integer  "trigger_after_event_id"
    t.integer  "started_on"
    t.integer  "finished_on"
    t.integer  "max_duration",           default: 0
    t.boolean  "current",                default: true
    t.boolean  "success",                default: false
    t.text     "summary"
    t.text     "description"
    t.integer  "winning_project_id"
    t.string   "icon"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "events", ["event_type", "current"], name: "index_events_on_event_type_and_current", using: :btree
  add_index "events", ["started_on", "finished_on", "success"], name: "index_events_on_started_on_and_finished_on_and_success", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "facility_type_id"
    t.boolean  "powered",                     default: true
    t.boolean  "maintained",                  default: true
    t.integer  "level",                       default: 1
    t.integer  "producing_trade_good_id"
    t.integer  "producing_equipment_type_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "facilities", ["citizen_id", "facility_type_id"], name: "index_facilities_on_citizen_id_and_facility_type_id", using: :btree

  create_table "facility_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "district_id"
    t.text     "description"
    t.string   "icon"
    t.integer  "build_cost",        default: 1000
    t.integer  "maintenance_cost",  default: 100
    t.integer  "employees",         default: 10
    t.integer  "automation",        default: 50
    t.integer  "power_consumption", default: 1
    t.integer  "power_generation",  default: 0
    t.integer  "pollution",         default: 0
    t.integer  "housing_mod",       default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "facility_types", ["district_id"], name: "index_facility_types_on_district_id", using: :btree

  create_table "global_effects", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "started_on"
    t.integer  "expires_on"
    t.boolean  "active",             default: true
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.integer  "infrastructure_mod", default: 0
    t.integer  "grid_mod",           default: 0
    t.integer  "power_mod",          default: 0
    t.integer  "stability_mod",      default: 0
    t.integer  "climate_mod",        default: 0
    t.integer  "liberty_mod",        default: 0
    t.integer  "security_mod",       default: 0
    t.integer  "borders_mod",        default: 0
    t.integer  "inflation_mod",      default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "global_effects", ["active"], name: "index_global_effects_on_active", using: :btree
  add_index "global_effects", ["started_on", "expires_on"], name: "index_global_effects_on_started_on_and_expires_on", using: :btree

  create_table "global_snapshots", force: :cascade do |t|
    t.integer  "infrastructure",           default: 0
    t.integer  "grid",           limit: 8, default: 0
    t.integer  "power",          limit: 8, default: 0
    t.integer  "stability",                default: 0
    t.integer  "climate",                  default: 0
    t.integer  "liberty",                  default: 0
    t.integer  "security",                 default: 0
    t.integer  "borders",                  default: 0
    t.integer  "turn",                     default: 0
    t.integer  "inflation",                default: 0
    t.integer  "citizens",                 default: 0
    t.integer  "gdp",            limit: 8, default: 0
    t.integer  "interest",                 default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "global_snapshots", ["turn"], name: "index_global_snapshots_on_turn", using: :btree

  create_table "globals", force: :cascade do |t|
    t.integer  "infrastructure",           default: 0
    t.integer  "grid",           limit: 8, default: 0
    t.integer  "power",          limit: 8, default: 0
    t.integer  "stability",                default: 0
    t.integer  "climate",                  default: 0
    t.integer  "liberty",                  default: 0
    t.integer  "security",                 default: 0
    t.integer  "borders",                  default: 0
    t.integer  "turn",                     default: 0
    t.integer  "inflation",                default: 0
    t.integer  "citizens",                 default: 0
    t.integer  "gdp",            limit: 8, default: 0
    t.integer  "interest",                 default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "help_topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_index"
    t.text     "summary"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "citizen_id"
    t.integer  "value",      limit: 8
    t.integer  "issued_on"
    t.integer  "matures_on"
    t.integer  "interest"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.string   "profession_group"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "professions", ["name", "profession_group"], name: "index_professions_on_name_and_profession_group", using: :btree

  create_table "project_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "citizen_id"
    t.integer  "joined_on"
    t.integer  "left_on"
    t.boolean  "active",       default: true
    t.integer  "contribution", default: 0
    t.integer  "wages",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "project_members", ["project_id", "citizen_id", "active"], name: "index_project_members_on_project_id_and_citizen_id_and_active", using: :btree

  create_table "project_resources", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "trade_good_id"
    t.integer  "quantity",      default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "project_resources", ["project_id", "trade_good_id"], name: "index_project_resources_on_project_id_and_trade_good_id", using: :btree

  create_table "project_skill_points", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "skill_id"
    t.integer  "points",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "project_skill_points", ["project_id", "skill_id"], name: "index_project_skill_points_on_project_id_and_skill_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "leader_id"
    t.integer  "event_id"
    t.integer  "began_on"
    t.integer  "finished_on"
    t.string   "status",      default: "Started"
    t.integer  "wages"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "projects", ["event_id", "status"], name: "index_projects_on_event_id_and_status", using: :btree
  add_index "projects", ["leader_id"], name: "index_projects_on_leader_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "skill_group"
    t.text     "description"
    t.string   "icon"
    t.integer  "primary_profession_id"
    t.integer  "secondary_profession_id"
    t.integer  "tertiary_profession_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "skills", ["name", "skill_group"], name: "index_skills_on_name_and_skill_group", using: :btree
  add_index "skills", ["primary_profession_id"], name: "index_skills_on_primary_profession_id", using: :btree
  add_index "skills", ["secondary_profession_id"], name: "index_skills_on_secondary_profession_id", using: :btree
  add_index "skills", ["tertiary_profession_id"], name: "index_skills_on_tertiary_profession_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trade_good_raw_materials", force: :cascade do |t|
    t.integer  "trade_good_id"
    t.integer  "raw_material_id"
    t.integer  "quantity",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "trade_good_raw_materials", ["trade_good_id", "raw_material_id"], name: "tgrm_mapping", using: :btree

  create_table "trade_goods", force: :cascade do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.integer  "exchange_price",     default: 0
    t.integer  "total",              default: 0
    t.integer  "produced_last_turn", default: 0
    t.integer  "for_sale",           default: 0
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
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
    t.integer  "failed_attempts",        default: 0,        null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "role",                   default: "player"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
